#!/bin/bash

############functions###########
aptitude_command(){
	aptitude $1 >> /tmp/aptitude_update.log &
	pid=$!
	while kill -0 $pid 2> /dev/null
	do
 		echo -n "."
  		sleep 0.5
	done
}

add_repo (){
	echo "##### Starting complete Software upgrade. This can take several minutes..."
	aptitude_command update
	aptitude_command "upgrade -y"
	echo "##### Software upgrade finished"
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 8756C4F765C9AC3CB6B85D62379CE192D401AB61
	echo deb http://dl.bintray.com/seafile-org/deb jessie main | tee /etc/apt/sources.list.d/seafile.list
	aptitude_command update
	aptitude_command "install -y $1"
}

get_valid_username(){
    valid=$(cut -d: -f1 /etc/passwd | awk '{printf "%s|",$0} END {print ""}')
    choice=$SUDO_USER
    whiptail --inputbox "Enter the local username from your account: (Default "$SUDO_USER")" 8 78 Blue --title "Debian username" 2>userSelect
    choice=$(cat userSelect)
    eval "case $choice in
        [$valid]* )
        username="$choice"
        ;;
    esac"
    rm userselect
}

check_env(){
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
}

get_login_email(){
	exitstatus=1
	while [[ $exitstatus != [0] ]];do login_email=$(whiptail --inputbox "Enter your Seafile login email address:" 8 78 --title "Seafile email" 3>&1 1>&2 2>&3); exitstatus=$?; done
}

get_login_password(){
	exitstatus=1
	while [[ $exitstatus != [0] ]];do login_password=$(whiptail --passwordbox "Enter your Seafile login password:" 8 78 --title "Seafile password" 3>&1 1>&2 2>&3); exitstatus=$?; done
}

get_local_dir(){
	exitstatus=1
	while [[ $exitstatus != [0] ]];do local_dir=$(whiptail --passwordbox "Enter local directory you want to sync: (/home/marius for example):" 8 78 /home/ --title "Directory to sync" 3>&1 1>&2 2>&3); exitstatus=$?; done
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

install_gui_client(){
	add_repo seafile-gui
	get_valid_username
	sudo -u $username dropbox stop
	create_dirs $username
	check_env $username
	get_ignoLink /home/"$username"
	whiptail --title "Restart" --menu "The window manager must now be restartet, this will close all open applications." 25 120 16 \
	"Restart window manager now" "recommended" \
	"Restart window manager later" "not recommended" 2>restartSelect
	restartChoice=$(cat restartSelect)
	echo $restartChoice
		case $restartChoice in
			["Restart window manager now"]*)
				/etc/init.d/lightdm restart
				/etc/init.d/gdm restart
				;;

			["Restart window manager later"]*)
				whiptail --title "Restart needed!" --infobox "Please restart your computer as soon as possible and don't use the GUI client without a restart!" 8 78
				;;
		esac
	rm restartSelect
}

install_cli_client(){
	add_repo seafile-cli
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
}

#################functions end###########

#################variable initiation###
username="$SUDO_USER"
arrayHomes=($(cd /home; ls -d */))
#################variable initiation end###

whiptail --title "Seafile installer" --menu "Choose a client to install. The installer cannot be cancelled." 25 120 16 \
"Graphical" "Return to the main menu." \
"Commandline" "Add a user to the system." \
"Conflicts" "Select this if your folder conflicts with system path (see ecoevolpara.rtfd.io)." \
"Uninstall" "Uninstall any previous installed Seafile client." \
"Exit" "Exits the Installer." 2>clientSelect
clientChoice=$(cat clientSelect)
echo $clientChoice

case $clientChoice in
	[Graphical]*)
    	install_gui_client
        ;;

    [Commandline]*)
        install_cli_client
        ;;

    [Conflicts]*)
		get_valid_username
		killall seafile-applet
		rm -rf /home/$username/.ccnet /home/$username/seafile /home/$username/Seafile
		check_env $username
		whiptail --title "Finished" --infobox "Conflicts should been solved, restart the installer and install the client again." 8 78
		break;;

    [Uninstall]*)
		get_valid_username
		aptitude_command "purge -y seafile-cli seafile-gui"
		killall seafile-applet
		rm -rf /home/$username/.ccnet /home/$username/Seafile /home/$username/seafile /home/seafile/$username /etc/seafile/$username
		rm /usr/local/bin/seafile_startup/start_$username.sh
		whiptail --title "Finished" --infobox "Uninstallation is finished." 8 78
		break;;

    [Exit]* )
    break;;
esac

rm clientselect
echo "###### Client installation finished"