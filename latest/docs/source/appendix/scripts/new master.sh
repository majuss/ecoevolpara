#new master

#!/bin/bash
# maintenance run for harriet 


#todo: get btrfs mountpoints --- mountpoints=($(mount | grep btrfs | awk '{print $3}'))

mkdir /tmp/maintenance_script
servername=$(hostname)																#get the hostname of the current machine
slack_apikey=$(cat /usr/local/bin/slack_apikey.txt)									#importing the slack API Key
timestamp_v=$(date +"%Y-%m-%d")														#getting a timestamp
rm "/tmp/maintenance_script/"$servername"_hardware-status_"$timestamp_v".txt"			#removes the output of the script in case your are running it several times a day for testing
save_to_file="/tmp/maintenance_script/"$servername"_hardware-status_"$timestamp_v".txt"	#path where output will be saved
numberofdisks=$(lsblk -S | grep 'sas\|sata' | wc -l)								#get number of sas and sata harddrives
numberoffs=$(btrfs fi show | grep uuid | wc -l)										#get the number of btrfs filesystems
sum_diskfs=$((numberofdisks + numberoffs))											#add the numberof disks and the number of btrfs filesystems together
alphabet_array=( {a..z} )															#create an alphabet in an array

for ((i=0; i<numberofdisks; i++))													#loop over the alphabet array as often as disks are installed
do smartctl -t short /dev/sd${alphabet_array[i]}									#start the smartselftest for every drive
done

sleep 300																			#wait for the selftest to get finished

echo "\n---------------------------SMART Status of all HDDs------------------------------\n" >> "$save_to_file"

for ((i=0; i<numberofdisks; i++))													#loop over the alphabet array as often as disks are installed
do smartctl -a /dev/sd${alphabet_array[i]} >> $save_to_file							#save the results to the file
done

echo "\n---------------------------btrfs Status of all volumes------------------------------\n" >> "$save_to_file"

btrfs scrub status / >> $save_to_file
btrfs scrub status /localstorage >> $save_to_file

echo "\n---------------------------Status of all temp-sensors------------------------------\n" >> "$save_to_file"

sensors >> $save_to_file

numberofgreps=$(($(grep "self-assessment test result: PASSED" $save_to_file | wc -l) + $(grep "with 0 errors" $save_to_file | wc -l))) #grep the number of health status "ok" and add it with "grep 0 error"


if servername=svalbard
	then
	do check free space
fi

if [ "$numberofgreps" -eq "$sum_diskfs" ]
	then
	curl -F initial_comment="All tests passed succesfull :white_check_mark::white_check_mark::white_check_mark:" -F file=@$save_to_file -F title=""$servername"'s maintenance report from $timestamp_v" -F token="$slack_apikey" -F channels="infrastructure-it" https://slack.com/api/files.upload
else
	curl -F initial_comment="Some tests were not succesfull :scream::rage::exclamation: You should worry about the disks or the filesystems:exclamation: Please check the logs:exclamation:" -F file=@$save_to_file -F title=""$servername"'s maintenance report from $timestamp_v" -F token="slack_apikey" -F channels="infrastructure-it" https://slack.com/api/files.upload
fi