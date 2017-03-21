pkg=0
setterm -msg off # Disable kernel messages to this terminal
setterm -blank 0 # Disable screen blanking
aptitude -y upgrade | \
    tr '[:upper:]' '[:lower:]' | \
while read x; do
    case $x in
        *upgraded*newly*)
            u=${x%% *}
            n=${x%% newly installed*}
            n=${n##*upgraded, }
            r=${x%% to remove*}
            r=${r##*installed, }
            pkgs=$((u*2+n*2+r))
            pkg=0
        ;;
        unpacking*|setting\ up*|removing*\ ...)
            if [ $pkgs -gt 0 ]; then
                pkg=$((pkg+1))
                x=${x%% (*}
                x=${x%% ...}
                x=$(echo ${x:0:1} | tr '[:lower:]' '[:upper:]')${x:1}
                printf "XXX\n$((pkg*100/pkgs))\n${x} ...\nXXX\n$((pkg*100/pkgs))\n"
            fi
        ;;
    esac
done | whiptail --title "Installing Packages" \
        --gauge "Preparing installation..." 7 70 0
setterm -msg on # Re-enable kernel messages
invoke-rc.d kbd restart # Restore screen blaking to default setting


while read x; do

    case $x in
done})




COLOR=$(whiptail --inputbox "What is your favorite Color?" 8 78 Blue --title "Example Dialog" 3>&1 1>&2 2>&3)
                                                                        # A trick to swap stdout and stderr.
# Again, you can pack this inside if, but it seems really long for some 80-col terminal users.
exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "User selected Ok and entered " $COLOR
else
    echo "User selected Cancel."
fi

echo "(Exit status was $exitstatus)"



while [[ $exitstatus != [0] ]];do COLOR=$(whiptail --title "Installing Packages" --gauge "Preparing installation..." 7 70 0); aptitude update; exitstatus=$?; done

#enter something and dont give up
exitstatus=1
while [[ $exitstatus != [0] ]];do COLOR=$(whiptail --inputbox "What is your favorite Color?" 8 78 Blue --title "Example Dialog" 3>&1 1>&2 2>&3); exitstatus=$?; done





aptitude update >> /tmp/aptitude_update.log &
pid=$!
while kill -0 $pid 2> /dev/null
do
  echo -n "."
  sleep 0.5
done

whiptail --title "Menu example" --menu "Choose a client to install." 25 120 16 \
"Graphical" "Return to the main menu." \
"Commandline" "Add a user to the system." \
"Conflicts" "Select this if your folder conflicts with system path (see ecoevolpara.rtfd.io)." \
"Uninstall" "Uninstall any previous installed Seafile client." \
"Exit" "Exits the Installer." 2>selection

choice=$(cat selection)
echo $choice


case $choice in
        [Graphical]* )
            echo "gui"
        ;;
        [Commandline]* )
            echo "cmd"
        ;;
        [Conflicts]* )
            echo "Fixing..."
        ;;
        [Uninstall]* )
            echo "Uninstalling..."
        ;;
        [Exit]* )
        ;;
esac

NEWT_COLORS='
  window=,red
  border=white,red
  textbox=white,red
  button=black,white
  root=,magenta
' \
whiptail --msgbox "passwords don't match" 0 0

