#!/bin/bash

############functions###########
dropbox stop
add_repo (){
	echo "##### Starting complete Software upgrade. This can take several minutes..."
	aptitude update > /dev/null
	aptitude upgrade -y > /dev/null
	echo "##### Software upgrade finished"

	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 8756C4F765C9AC3CB6B85D62379CE192D401AB61
	echo deb http://dl.bintray.com/seafile-org/deb jessie main | tee /etc/apt/sources.list.d/seafile.list
	aptitude update > /dev/null
	aptitude install -y $1
}

get_valid_username(){
	valid=$(cut -d: -f1 /etc/passwd | awk '{printf "%s|",$0} END {print ""}')
	choice=$SUDO_USER
	while true; do
		exitstatus=1
		while [[ $exitstatus != [0] ]];do choice=$(whiptail --inputbox "Enter the local username from your account: (Default "$SUDO_USER")" 8 78 Blue --title "Debian username" 3>&1 1>&2 2>&3); exitstatus=$?; done
		#read -p "Enter the local username from your account: (Default "$SUDO_USER"): " 'choice'
		eval "case \"$choice\" in
		[$valid]* )
		username="$choice"
		break;;
		*)
		echo "invalid username"
		;;
	esac"
done
}

function check_env(){
	env_exists=$(cat /home/$1/.xsessionrc | grep CCNET | wc -l)
	if [ "$env_exists" -gt "0" ]
		then echo "Env var already existend"
	else
		echo -e "CCNET_CONF_DIR=/etc/seafile/\$USER" >> /home/"$1"/.xsessionrc
		sudo chown $1:$1 /home/$1/.xsessionrc
	fi
}

get_library_id(){
	exitstatus=1
	while [[ $exitstatus != [0] ]];do library_id=$(whiptail --inputbox "Enter your Seafile-library ID you want to sync (see documentation):" 8 78 Blue --title "Seafile-LiberaryID" 3>&1 1>&2 2>&3); exitstatus=$?; done

	#read -p "Enter your seafile-library ID you want to sync (see documentation): " 'library_id'
}

get_login_email(){
	exitstatus=1
	while [[ $exitstatus != [0] ]];do login_email=$(whiptail --inputbox "Enter your Seafile login email address:" 8 78 --title "Seafile email" 3>&1 1>&2 2>&3); exitstatus=$?; done

	#read -p "Enter your seafile login email: " 'login_email'
}

get_login_password(){
	exitstatus=1
	while [[ $exitstatus != [0] ]];do login_password=$(whiptail --passwordbox "Enter your Seafile login password:" 8 78 --title "Seafile password" 3>&1 1>&2 2>&3); exitstatus=$?; done
	#read -p "Enter your seafile login password: " 'login_password'
}

get_local_dir(){
	exitstatus=1
	while [[ $exitstatus != [0] ]];do local_dir=$(whiptail --passwordbox "Enter local directory you want to sync: (/home/marius for example):" 8 78 /home/ --title "Directory to sync" 3>&1 1>&2 2>&3); exitstatus=$?; done
	#read -p "Enter local directory you want to sync: (/home/marius for example): " 'local_dir'
}

create_dirs(){
for i in "${arrayHomes[@]}"
do
	mkdir /home/seafile /home/seafile/"$i" /etc/seafile /etc/seafile/$i /usr/local/bin/seafile_startup
	chown $i:$i /home/seafile/"$i" /etc/seafile/"$i"
	check_env $i
done
}

get_ignoLink(){
	dlPath=$(echo "$1"/seafile-ignore | tr -s /)
	wget https://raw.githubusercontent.com/majuss/ecoevolpara/master/latest/docs/source/appendix/scripts/seafile-ignore.txt -O $dlPath
}
#################functions end###########

#################variable initiation###
username="$SUDO_USER"
arrayHomes=($(cd /home; ls -d */))
#################variable initiation end###



while true; do
    read -p "Which client do you want to install? graphical[1] or commandline[2]. Hit [3] to uninstall any previous installed client or [4] when your home folder conflicts with system path." client_type
    case $client_type in
        [1]* )	add_repo seafile-gui #case seafile-gui
				get_valid_username
				sudo -u $username dropbox stop
				create_dirs $username
				check_env $username
				get_ignoLink /home/"$username"
				while true; do
					read -p "The window manager must now be restartet, this will close all open applications. Do now [1], later [2]: " restart
					case $restart in
						[1]*)
								/etc/init.d/lightdm restart
								/etc/init.d/gdm restart
								break;;

						[2]*)	echo "Please restart your computer as soon as possible and don't use the GUI client without a restart!"
								break;;

						*)		;;
					esac
				done
				break;;

        [2]* )	add_repo seafile-cli #case seafile-cli
        		get_valid_username
        		sudo -u $username dropbox stop
        		get_login_email
        		get_login_password
        		get_local_dir
        		get_library_id
        		create_dirs $username
        		get_ignoLink $local_dir
        		sudo -u $username seaf-cli init -c /etc/seafile/$username -d /home/seafile/$username
        		sudo -u $username seaf-cli start -c /etc/seafile/$username
        		sudo -u $username seaf-cli sync -l "$library_id" -s https://svalbard.biologie.hu-berlin.de -d "$local_dir" -c /etc/seafile/"$username" -u "$login_email" -p "$login_password"
        		seaf-cli start -c /etc/seafile/"$username"; sleep 2; seaf-cli sync -l "$library_id" -s https://svalbard.biologie.hu-berlin.de -d "$local_dir" -c /etc/seafile/"$username" -u "$login_email" -p "$login_password"
        		echo -e "seaf-cli start -c /etc/seafile/$username" >> /usr/local/bin/seafile_startup/start_"$username".sh
				chown $username:$username /usr/local/bin/seafile_startup/start_"$username".sh
				cron_line="@reboot bash /usr/local/bin/seafile_startup/start_"$username".sh"
				(crontab -l; echo "$cron_line" ) | sort | uniq | crontab -
        		break;;

        [3]* )	get_valid_username #uninstall seafile
				aptitude purge -y seafile-cli seafile-gui
				rm /usr/local/bin/seafile_startup/start_$username.sh
				rm -rf /etc/seafile/$username
				rm -rf /home/seafile/$username
				break;;

		[4]* )	get_valid_username #system path conflicts
				killall seafile-applet
				rm -rf /home/$username/.ccnet
				check_env
				break;;

        * ) echo "Please answer 1, 2, 3 or 4.";;
    esac
done

echo "###### Client installation finished"


#case only to chose -> installing in functions
