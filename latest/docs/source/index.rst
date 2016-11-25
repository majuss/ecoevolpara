.. Documentation-ecoevolpara documentation master file, created by
   sphinx-quickstart on Fri Nov 25 13:42:25 2016.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to Documentation-ecoevolpara's documentation!
=====================================================

.. toctree::
   :maxdepth: 2
   :caption: Contents:



#Software

##Filesystem and harddiskmanagement

###btrfs


Btrfs is with ZFS the only filesystem that can detect and prevent silent-data-corruption when paired with ECC-RAM. Additionally you can create software-RAIDs very easily without any controller. We don’t use RAID 5 since restoring data is a pain and it creates much more IO’s which is not beneficial when working with datasets. Also the prices for huge harddisks are now very low. Btrfs will only work satisfyingly with Kernel 4.4 and above. Thats why we are using Debian stretch/sid. The command:


`btrfs fi show`


will show all set up btrfs-filesystems and the free space on them. Every fs will handled with an UUID.


`btrfs scrub start /mountpoint`


Will scrub the targeted fs. This means the fs will check all block-checksums and correct errors automatically. When started once it will run til finished. Scrubbing will take a lot of time (100 mb/s). You should scrub the fs once every month. The status of the recent scrub can be checked with:


`btrfs scrub status /mountpoint`


To create a complete new RAID or add a harddisk to an existing one you first have to format the drive with a GPT:


`parted -s /dev/sdz mklabel gpt mkpart primary 1% 100%`


This command will use parted to create a GPT on sdz (you can read out the drive-letters with lsblk). You should restart the server after this step, because the new disk will likely not be detected correctly. After the restart you add the device to an existing RAID with:


`btrfs device add /dev/sdz1 /`


Here sdz1 getting added to the RAID /. You can create a complete new RAID 1 from multiple devices with:


`mkfs.btrfs -d raid1 -m raid1 /dev/sdc1 /dev/sdd1 /dev/sde1 /dev/sdf1`


After adding devices to RAIDs you always have to balance the data between them.


`btrfs balance start -mconvert=raid1 -dconvert=raid1 /`


###Mounting the SAN storage


The SAN - storage area network - is a network storage attached over 8 Gbit fibre channel. Currently we have 15 TB of storage mounted on harriet at /SAN.


There is a manual to mount the SAN under Ubuntu: Multipathing-Ubuntu-1404.pdf (inside of the docu-directory).


Additional to the manual see this error which will occur: http://pissedoffadmins.com/os/mount-unknown-filesystem-type-lvm2_member.html


> load device module
modprobe dm-mod
> change the volumes that exist to active
vgchange -ay
> mount the logical partition
mkdir -p /mnt/VolGroup00/LogVol00
mount /dev/VolGroup00/LogVol00 /mnt/VolGroup00/LogVol00




##Incremental backup


Our backup from harriet and its mounted fibrechannel-space SAN is realised with rdiff-backup (installed with: aptitude install rdiff-backup). The software has to be installed on the server and the machine which will get backed up. Additionally the server needs a working root ssh-connection to all clients. This means you have to store the pub-key from the server on every client in /root/.ssh/authorized_keys. See 2.3.2 for the description of the cronjob which will trigger the backup.

To restore any file from harriet you first have to login as the user rdiff-backup (password is "rdiff"), then you have to type:

`rdiff-backup -r $days_to_go_back $file_to_restore $targed_path`

So for example to restore alices whole home director from 10 days ago:

`rdiff-backup -r 10D /data/backup_harriet/localstorage/alice /data/backup_restore/alice`


##Custom cronjobs


You can look at the cronjobs with crontab -e. The scripts which get triggered be these jobs are usually located in /usr/local/bin. Make sure the scripts are executable (chmod +x).


example:

`00 01 * * 7 [ $(date +\%d) -le 07 ] && /usr/local/bin/btrfs_scrub.sh`


`00 12 * * 7 [ $(date +\%d) -le 07 ] && /usr/local/bin/maintenance_svalbard.sh`


###Update blastdb nt, nr and taxdb


This cronjob will download the actual blast databases nt and nr with wget over ftp. The script auomatically store the old dbs marked with a timestamp in a directory called old.blastdb. It is currently installed on beagle for testing purposes only and will run once on the first saturday off each month. This job is located in /usr/local/bin.


###Backup with rdiff-backup (svalbard)


This cronjob simply trigger the rdiff-backup.sh script at 3:00 each day which is usually located in /usr/local/bin on svalbard.


###btrfs scrubbing (beagle, harriet, svalbard)


This cronjob is starting a scrub every month on the first sunday at 01:00. 


###Starting geneious VM (beagle)


This cronjob will start a QEMU command to start the virtual machine running the Geneious license server. This license server is running in the vm due to incompatibilities with modern system libraries. Never update this vm!


For furthy documentation about vm check x.x. or 2.4 for information on Geneious.


###Maintenance report over Slack (beagle, harriet, svalbard)


This job will post a maintenance report every first sunday at 12:00 (after hopefully the scrubbing is done)


##Geneious license server (running on beagle)


A lot of members of the institute are using a software called “geneious” to analyse DNA-data. We have 6 licenses which are ONLY compatible with the version 6.1.8 (you can get this old version here: http://www.geneious.com/previous-versions). The server providing the licenses is beagle. Additionally to the license server, beagle is running a mysql server, which provides the “shared database” for all geneious-Users at the institute.


###Setup the mysql database-server https://support.rackspace.com/how-to/installing-mysql-server-on-ubuntu/


####Setting up the floating license manager 


#Debian

Debian is a common and completely free Linux distribution. It is released in 3 release-branches. Stable, stretch and experimental. We are using the stretch release, since debian-stable is very conservtive and updates getting rolled out pretty slow.


##Install software

First look if you can find the software you are looking for in the official debian repositories with:

`aptitude search $softwarename`

This will list all findings, if nothing get's posted your software is not inside the official repos. Then you have to evaluate if you really need this software... When you really need it google for a download link. You should go for a package with the ending ".deb" which indicates a debian package. Often these packages are listed under Ubuntu, since Ubuntu is a Debian-derivate.

##Update and upgrade Debian

`aptitude update`

Will update the package list/cache. Always run this before you upgrading or installing software!

`aptitude upgrade`

Will upgrade all packages which are outdated.


#Seafile

Seafile is a program which enables us to host our own cloud system very much like Dropbox, iCloud or Onedrive. The mainthought behind it, is to synchronize all /home/ directories between harriet, beagle and all clients like the Dell Optiplex and the Intel NUCs. This will enable every user to log into any client computer and syncs their homes to it.

The Server on which all seafile data is stored is Svalbard. On Svalbard a user named seafile drives the seafile-server software.

On the Client site there are 2 major branches. First of all there is harriet, who synces the home directories through the seaf-cli client which runs individually for every user on harriet. On the normal clients every user can simply use the gui client or he can setup the cli client if desired.

To set up the seafile-gui client on a normal client computer with a clean debian install you need to first of all download it via aptitude, after adding the repo and key (LINK TO DL). When an error occurs while installing which includes the libssl1.0.0 you need to google the package for debian, download, and install it via dpkg -i.

After installing it you have to add a global environment variable for the config file, because seafile can't sync sirectories which contain the config(".ccnet") directory so you have to make sure it gets stored at a different place with the env. variable.

`export CCNET_CONF_DIR=/etc/seafile/$USER` in /etc/profile will create the variable for every user in the according directory. Now you have to create the directories for every user.

A seafile-ignore.txt should be included in every Library you wish to sync, espacially inside of the homes. The file should contain a wild card for all dot-files/directories. You should also exclude a directory which includes all github projects, to avoid sync conflicts with git.






here is a pdf file :download:`pdf <appendix/ChassisSC836.pdf>`




to documentate:


custom cronjobs
backup
vms
geneiousvm
update debian
setting up new machine
mount SAN



Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
