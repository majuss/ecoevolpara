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

get_local_sync(){
	read -p "Enter local directory you want to sync: " local_dir
}
#################functions end###########

#################variable initiation###
username="$SUDO_USER"
#################variable initiation end###



while true; do
    read -p "Which client do you want to install? graphical[1] or commandline[2]: " client_type
    case $client_type in
        [1]* )	add_repo
				echo "installing gui client" #aptitude install -y seafile-gui
				get_valid_username

				echo "creating dir for user $username" #mkdir /home/seafile /home/seafile/"$username" /etc/seafile /etc/seafile/$username
				echo "owning dir" #chown $username:$username /home/seafile/"$username" /etc/seafile/$username
				echo "exporting env_var" #export CCNET_CONF_DIR=/etc/seafile/$username
				
				break;;


        [2]* )	add_repo
        		echo "installing cli client" #aptitude install -y seafile-cli
        		get_valid_username
        		get_login_email
        		get_login_password
        		get_local_sync
        		get_library_id
        		echo "creating dir for user $username" #mkdir /home/seafile /home/seafile/"$username" /etc/seafile /etc/seafile/$username
				echo "owning dir" #chown $username:$username /home/seafile/"$username" /etc/seafile/$username
				echo "exporting env_var" #export CCNET_CONF_DIR=/etc/seafile/$username
				echo "wget ignore list" #wget ignore list -O /home/$username
        		sudo -u $username seaf-cli init -c /etc/seafile_confs/$username -d /home/seafile/$username
        		sudo -u $username seaf-cli start -c /etc/seafile/$username
        		sudo -u $username seaf-cli sync -l $library_id -s https://svalbard.biologie.hu-berlin.de -d /home/$username -c /etc/seafile/$username -u $login_email -p login_password
        		


        		break;;
        * ) echo "Please answer 1 or 2.";;
    esac
done