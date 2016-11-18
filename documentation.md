2. Software


2.1. Filesystem and harddiskmanagement


2.1.1 btrfs


Btrfs is with ZFS the only filesystem that can detect and prevent silent-data-corruption when paired with ECC-RAM. Additionally you can create software-RAIDs very easily without any controller. We don’t use RAID 5 since restoring data is a pain and it creates much more IO’s which is not beneficial when working with datasets. Also the prices for huge harddisks are now very low. Btrfs will only work satisfying with Kernel 4.4 and above. Thats why we are using Debian stretch/sid. The command:


"btrfs fi show"


will show all set up btrfs-filesystems and the free space on them. Every fs will handled with an UUID.


"btrfs scrub start /mounted_fs"


Will scrub the targeted fs. This means the fs will check all block-checksums and correct errors automatically. When started once it will run til finished. Scrubbing will take a lot of time (100 mb/s). You should scrub the fs once every month. The status of the acutal scrub can be checked with:


“btrfs scrub status /mounted_fs”


To create a complete new RAID or add a harddisk to an existing one you first have to format the drive with a GPT:


“parted -s /dev/sdz mklabel gpt mkpart primary 1% 100%”


This command will use parted to create a GPT on sdz (you can read out the drive-letters with lsblk). You should restart the server after this step, because the new disk will likely not be detected correctly. After the restart you add the device to an existing RAID with:


“btrfs device add /dev/sdz1 /”


Here sdz1 getting added to the RAID /. You can create a complete new RAID 1 from multiple devices with:


"mkfs.btrfs -d raid1 -m raid1 /dev/sdc1 /dev/sdd1 /dev/sde1 /dev/sdf1"


After adding devices to RAIDs you always have to balance the data between them.


"btrfs balance start -mconvert=raid1 -dconvert=raid1 /"


2.1.2 Mounting the SAN storage


The SAN - storage area network - is a network storage attached over 8 Gbit fibre channel. Currently we have 15 TB of storage mounted on harriet at /SAN.


There is a manual to mount the SAN under Ubuntu: Multipathing-Ubuntu-1404.pdf (inside of the docu-directory).


Additional to the manual see this error which will occur: http://pissedoffadmins.com/os/mount-unknown-filesystem-type-lvm2_member.html


#load device module
modprobe dm-mod
#change the volumes that exist to active
vgchange -ay
#mount the logical partition
mkdir -p /mnt/VolGroup00/LogVol00
mount /dev/VolGroup00/LogVol00 /mnt/VolGroup00/LogVol00




2.2. Incremental backup


Our backup from harriet, the mounted fibrechannel-space SAN and all clients is realised with rdiff-backup (installed with: aptitude install rdiff-backup). The software has to be installed on the server and the machine which will get backed up. Additionally the server needs a working root ssh-connection to all clients. This means you have to store the pub-key from the server on every client in /root/.ssh/authorized_keys. See 2.3.2 for the description of the cronjob which will trigger the backup.




2.3. Custom cronjobs


You can look at the cronjobs with crontab -e. The scripts which get triggered be these jobs are usually located in /usr/local/bin. Make sure the scripts are executable (chmod +x).


example:
---
00 01 * * 7 [ $(date +\%d) -le 07 ] && /usr/local/bin/btrfs_scrub.sh 


00 12 * * 7 [ $(date +\%d) -le 07 ] && /usr/local/bin/maintenance_svalbard.sh
---


2.3.1. Update blastdb nt and nr


This cronjob will download the actual blast databases nt and nr with wget over ftp. The script auomatically store the old dbs marked with a timestamp in a directory called old.blastdb. It is currently installed on beagle for testing purposes only and will run once on the first saturday off each month. This job is located in /usr/local/bin.


2.3.2 Backup with rdiff-backup (svalbard)


This cronjob simply trigger the rdiff-backup.sh script at 3:00 each day which is usually located in /usr/local/bin on svalbard.


2.3.3 btrfs scrubbing (beagle, harriet, svalbard)


This cronjob is starting a scrub every month on the first sunday at 01:00. 


2.3.4 Starting geneious VM (beagle)


This cronjob will start a QEMU command to start the virtual machine running the Geneious license server. This license server is running in the vm due to incompatibilities with modern system libraries. Never update this vm!


For furthy documentation about vm check x.x. or 2.4 for information on Geneious.


2.3.5 Maintenance report over Slack (beagle, harriet, svalbard)


This job will post a maintenance report every first sunday at 12:00 (after hopefully the scrubbing is done)


2.4 Geneious license server (running on beagle)


A lot of members of the institute are using a software called “geneious” to analyse DNA-data. We have 6 licenses which are ONLY compatible with the version 6.1.8 (you can get this old version here: http://www.geneious.com/previous-versions). The server providing the licenses is beagle. Additionally to the license server, beagle is running a mysql server, which provides the “shared database” for all geneious-Users at the institute.


2.4.1 Setup the mysql database-server https://support.rackspace.com/how-to/installing-mysql-server-on-ubuntu/


2.4.2 Setting up the floating license manager 


3. Debian


3.1 Update and upgrade Debian














to documentate:


custom cronjobs
backup
vms
geneiousvm
update debian
setting up new machine
mount SAN
