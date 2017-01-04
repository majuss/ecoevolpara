#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin


mkdir /tmp/maintenance_script
servername=$(hostname)																	#get the hostname of the current machine
slack_apikey=$(cat /usr/local/bin/slack_apikey.txt)										#importing the slack API Key
timestamp_v=$(date +"%Y-%m-%d")															#getting a timestamp
rm "/tmp/maintenance_script/"$servername"_hardware-status_"$timestamp_v".txt"			#removes the output of the script in case your are running it several times a day for testing
save_to_file="/tmp/maintenance_script/"$servername"_hardware-status_"$timestamp_v".txt"	#path where output will be saved
numberofdisks=$(lsblk -S | grep 'sas\|ata' | grep 'disk' | wc -l)						#get number of sas and sata harddrives including only disks no ODDs
numberoffilesystems=$(btrfs fi show | grep uuid | wc -l)								#get the number of btrfs filesystems
sum_diskfs=$((numberofdisks + numberoffilesystems))										#add the numberof disks and the number of btrfs filesystems together
freespace_echo=""																		#initialize an empty textstring for the freespace report on svalbard
mountpoints=$(mount | grep btrfs | awk '{print $3}')									#write all btrfs mountpoints into an array
alphabet_array=( {a..z} )																#create an alphabet in an array

for ((i=0; i<numberofdisks; i++))														#loop over the alphabet array as often as disks are installed
do smartctl -t short /dev/sd${alphabet_array[i]}										#start the smartselftest for every drive
done

sleep 300																				#wait for the selftest to get finished

echo "Check the documentation on: ecoevolpara.readthedocs.io on how to interpret this logfile." >> "$save_to_file"
echo "---------------------------SMART Status of all HDDs------------------------------" >> "$save_to_file"

for ((i=0; i<numberofdisks; i++))														#loop over the alphabet array as often as disks are installed
	do smartctl -a /dev/sd${alphabet_array[i]} >> $save_to_file							#save the results to the file
done

echo "---------------------------btrfs Status of all volumes------------------------------" >> "$save_to_file"


for ((i=0; i<numberoffilesystems; i++))
	do btrfs scrub status ${mountpoints[i]} >> $save_to_file							#loop over btrfs-filesystems and their mountpoints and save the status of the last scrub
done

echo "---------------------------Status of all temp-sensors------------------------------" >> "$save_to_file"

sensors >> $save_to_file

numberofgreps=$(($(grep 'self-assessment test result: PASSED\|SMART Health Status: OK' $save_to_file | wc -l) + $(grep "with 0 errors" $save_to_file | wc -l))) #grep the number of: "self-assessment test result: PASSED" from smartctl and add it with "with 0 errors" from btrfs scrub status


if [ "$servername" == "svalbard" ]
	then
	freespace_echo="There is "$(df -h | awk 'FNR == 9 {print $4}')" Space left on Svalbard."
fi

if [ "$numberofgreps" -eq "$sum_diskfs" ]
	then
	curl -F initial_comment="All tests passed succesfull :white_check_mark::white_check_mark::white_check_mark: $freespace_echo" -F file=@$save_to_file -F title=""$servername"'s maintenance report from $timestamp_v" -F token="$slack_apikey" -F channels="testing_bots" https://slack.com/api/files.upload
else
	curl -F initial_comment="Some tests were not succesfull :scream::rage::exclamation: You should worry about the disks or the filesystems:exclamation: Please check the logs:exclamation:" -F file=@$save_to_file -F title=""$servername"'s maintenance report from $timestamp_v" -F token="$slack_apikey" -F channels="testing_bots" https://slack.com/api/files.upload
fi