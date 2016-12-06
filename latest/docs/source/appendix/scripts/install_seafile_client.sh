#!/bin/bash

############functions###########

add_repo () {
echo "add key"			#apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 8756C4F765C9AC3CB6B85D62379CE192D401AB61
echo "add repo"			#echo deb http://dl.bintray.com/seafile-org/deb jessie main | tee /etc/apt/sources.list.d/seafile.list
echo "aptitude update"	#aptitude update
}

get_valid_username(){
valid=$(cut -d: -f1 /etc/passwd | awk '{printf "%s|",$0} END {print ""}')
choice=$SUDO_USER
while true; do
	read -p "Enter the local username from your account: (Default "$SUDO_USER"): " choice
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

get_library_id(){
	read -p "Enter your seafile-library ID you want to sync: " library_id
}

get_login_email(){
	read -p "Enter your seafile login email: " login_email
}

get_login_password(){
	read -p "Enter your seafile login password: " login_password
}

get_local_dir(){
	read -p "Enter local directory you want to sync: (/home/marius for example)" local_dir
}
#################functions end###########

#################variable initiation###
username="$SUDO_USER"
ignore_link="https://raw.githubusercontent.com/majuss/ecoevolpara/master/latest/docs/source/appendix/scripts/seafile-ignore.txt"
#################variable initiation end###



while true; do
    read -p "Which client do you want to install? graphical[1] or commandline[2]. Or hit [3] to uninstall any previous installed client " client_type
    case $client_type in
        [1]* )	add_repo
				aptitude install -y seafile-gui
				get_valid_username
				mkdir /home/seafile /home/seafile/"$username" /etc/seafile /etc/seafile/$username
				chown $username:$username /home/seafile/"$username" /etc/seafile/$username
				export CCNET_CONF_DIR=/etc/seafile/$username
				wget $ignore_link -O /home/"$username"/seafile-ignore.txt
				break;;


        [2]* )	add_repo
        		aptitude install -y seafile-cli
        		get_valid_username
        		get_login_email
        		get_login_password
        		get_local_dir
        		get_library_id
        		mkdir /home/seafile /home/seafile/"$username" /etc/seafile /etc/seafile/$username /usr/local/bin/seafile_startup
				chown $username:$username /home/seafile/"$username" /etc/seafile/$username
				export CCNET_CONF_DIR=/etc/seafile/$username
				wget ignore list -O /home/$username
        		sudo -u $username seaf-cli init -c /etc/seafile/$username -d /home/seafile/$username
        		sudo -u $username seaf-cli start -c /etc/seafile/$username
        		sudo -u $username seaf-cli sync -l $library_id -s https://svalbard.biologie.hu-berlin.de -d $local_dir -c /etc/seafile/$username -u $login_email -p login_password
        		echo "#!/bin/sh; seaf-cli start -c /etc/seafile/"$username"; sleep 2; seaf-cli sync -l "$library_id" -s https://svalbard.biologie.hu-berlin.de -d "$local_dir" -c /etc/seafile/"$username" -u "$login_email" -p "$login_password"" >> /usr/local/bin/seafile_startup/start_"$username.sh"
				chown $username:$username /usr/local/bin/seafile_startup/start_"$username.sh"
				#sudo -u $username echo ""

        		


        		break;;

        [3]* )	get_valid_username
				aptitude purge -y seafile-cli seafile-gui
				rm /usr/local/bin/seafile_startup/$username
				rm /etc/seafile/$username
				rm /home/seafile/$username




				break;;
        * ) echo "Please answer 1, 2 or 3.";;
    esac
done





#line="@reboot  /var/lib/seafile-client/seaf-cli-launcher"
#(crontab -l; echo "$line" ) | uniq | crontab -