# Incremental backup


## Backup with R-diff backup

Our backup from harriet and its mounted fibrechannel-space SAN is realised with rdiff-backup (installed with: `aptitude install rdiff-backup`). The software has to be installed on the server and the machine which will get backed up. Additionally the server needs a working ssh-connection to all clients. 


### R-diff backup configuration

1. Install the software with:

2. Create groups and a user:
```
groupadd -g 3500 rdiff-backup
useradd -u 3500 -s /bin/false -d /backup -m -c "rdiff-backup" -g rdiff-backup rdiff-backup
```
3. Change to the user rdiff-backup:
```
su -m rdiff-backup
```
4. Create ssh-key:
```
cd /backup
ssh-keygen
```
5. Create ssh shortcut and enter the simple name and the IP of the server you want to backup:
```
host harriet_backup
hostname IP_of_server
user root
```
4. Change the permissions of the ssh directory:
```
chmod -R go-rwx /backup/.ssh
```
5. Add the public key to the server you want to backup. Therefore connect to the remote server:
```
ssh user@harriet
```
Then get `root` or create the .ssh directory via sudo.
```
sudo mkdir /root/.ssh
```
And the pub-key of the backup server (Svalbard).
```
nano /root/.ssh/authorized_keys
```
After you added the key you need to append some commands in front of the key:
```
nano /root/.ssh/authorized_keys
```
and paste the following directly in front of the key:
```
command="rdiff-backup --server --restrict-read-only /",from="harriet.biologie.hu-berlin.de",no-port-forwarding,no-X11-forwarding,no-pty
```
So it should look similiar to this (you can get the domain adress of the server with: `dig -x IP_ADRESS`:
```
command="rdiff-backup --server --restrict-read-only /",from="harriet.biologie.hu-berlin.de",no-port-forwarding,no-X11-forwarding,no-pty ssh-rsa AAAAB3Nza[...]W1go9M= rdiff-backup@backup
```
Repair permissions of the .ssh directory:
```
chmod -R go-rwx /root/.ssh
```
6. Back on the backup-server type we test the backup with:
```
cd /backup
rdiff-backup harriet_backup::/REMOTE_DIRECTORY LOCAL_DORECTORY
```
This will backup the typed remote directory into the local one. When this is running successfull we are creating a cronjob.

7.  Run:
```
sudo crontab -e
```
And add something like this
```
40 2 * * * /usr/bin/rdiff-backup --exclude /tmp --exclude /mnt --exclude /proc --exclude /dev --exclude /cdrom --exclude /floppy server1_backup::/ /backup/backup_harriet
```
This is running the backup every night at 2:40 and is backing up `/` but excluding some recommend directories.

### Restore files from the backup

To restore any file from a backup you first have to login as the user rdiff-backup (password is found in the KeePassX-database), then you have to type:
```
rdiff-backup -r $days_to_go_back $path_to_file_to_restore $restore_targed_path
```
So for example to restore alices whole home directory from 10 days ago:
```
rdiff-backup -r 10D /data/backup_harriet/localstorage/alice /data/backup_restore/alice
```
The restore directory has to be owned by rdiff-backup so the user can write into it.

### Delete increments - free disk space

To delete old increments run: `rdiff-backup –remove-older-than 90D /data/backup_harriet` This will delete all increments which are older than 90 days.

### Back up the seafile-data

Additional to the server backups (harriet) you should backup the seafile-data directory. So in case of a corruption of these files you can restore all metadata.

## TSM-backup

 IBM Tivoli Storage Manager is a heavy backup software which enables clients to upload their backup onto TSM servers. TSM is now called IBM Spectrum Protect. We have the authorization to backup our server onto the HU TSM servers.

### Installing the client software

Installing the client server on a Debian system running kernel 4.9+ is somewhat complicated. You need several `.deb` packages to install the software.


1. Create a working directory and change into it: `mkdir tsm; cd tsm`

2. Download the latest `.deb` package from the [IBM support site] OR via direct link: 
```
wget ftp://public.dhe.ibm.com/storage/tivoli-storage-management/maintenance/client/v8r1/Linux/LinuxX86_DEB/BA/v810/8.1.0.0-TIV-TSMBAC-LinuxX86_DEB.tar
```

3. Decompress the downloaded `.tar` archive: `tar -xvf 8.1.0.0-TIV-TSMBAC-LinuxX86_DEB.tar`

4. Delete the outdated Filepath source: `rm tivsm-filepath-source.tar.gz` for a Debian running Kernel 4.9.0-2 you can download this Filepath source: INSERT FILEPATH SOURCE LINK. For any other Kernel you can try the above, or the one inside the `.tar` package. If they don't compile you have to write an E-Mail to IBM-staff (tsmosreq@us.ibm.com). He will fix the source code to fit your kernel version.

5. Check the release number of your TSM instance: `dpkg-deb -I tsmbackup/tivsm-api64.amd64.deb` and copy the `Version:` entry.

6. Install `make` and the Linux-headers: 
```
sudo aptitude update
sudo aptitude install build-essential linux-headers-amd64
```

Then extract the Filepath source: `tar -xf TIVsm-filepath-source_test.tar.gz`. Change into source directory: `cd jbb_gpl` and compile it with `make RELNUM=$copiedReleaseNumber deb`. If the compile can't finish successfull you can't continue, see step 4 for details. If `make` is not found you first have to run `sudo aptitude update` and then `sudo aptitude install build-essential linux-headers-amd64`. The compiling will create a `.deb` package in the `jbb_gpl` directory.

7. Install all TSM components by running the following commands:
```
cd ..
sudo dpkg -i jbb_gpl/tivsm-filepath-8.1.0-0.deb
sudo dpkg -i gskcrypt64_8.0-50.66.linux.x86_64.deb
sudo dpkg -i gskssl64_8.0-50.66.linux.x86_64.deb
sudo dpkg -i tivsm-api64.amd64.deb
sudo dpkg -i tivsm-apicit.amd64.deb
sudo dpkg -i tivsm-ba.amd64.deb
sudo dpkg -i tivsm-bacit.amd64.deb
sudo dpkg -i tivsm-bahdw.amd64.deb
sudo dpkg -i tivsm-jbb.amd64.deb
```
When every package was sucessfully installed head over to the configuration.

### TSM Configuration

1. Firt of all you have to alter the `init.d` registration of TSM. Open `/etc/init.d/dsmcad` with your favorite editor and go to line 92. 
Replace line 92 with: `if [ $ID = "debian" ]` this will make the script work correctly with Debian.
Try the script with: `sudo /etc/init.d/dsmcad status`

2. You should got the login credentials for the TSM-server from the workgroup-systemadminstrator. These credentials should contain the following 4 parameters which are needed to access the HU TSM server:
* A password
* SErvername
* TCPServeraddress
* NOdename

Also have a look at the official [HU configuration manual].
Open a new file:
```
nano /opt/tivoli/tsm/client/ba/bin/dsm.sys
```
And paste the following but replace the bold entries with the parameters mentioned above:
<pre>
************************************************************************
* Tivoli Storage Manager                                               *
*                                                                      *
* Sample Client System Options file for UNIX (dsm.sys.smp)             *
************************************************************************
* 
*  This file contains the minimum options required to get started
*  using TSM.  Copy dsm.sys.smp to dsm.sys.  In the dsm.sys file,
*  enter the appropriate values for each option listed below and
*  remove the leading asterisk (*) for each one.
*
*  If your client node communicates with multiple TSM servers, be
*  sure to add a stanza, beginning with the SERVERNAME option, for
*  each additional server.
*
************************************************************************
SErvername  <b>TSM-SERVERNAME</b>
   COMMMethod         TCPip
   TCPPort            1500
   TCPServeraddress   <b>TSM-SERVERNAME.cms.hu-berlin.de</b>
NOdename    SVALBARD_BIO
PASSWORDAccess  generate
* EXCLUDE.DIR "/home/user/test"
ERRORLOGName    /var/log/dsmerror.log
ERRORLOGRETENTION       60
SCHEDLOGName    /var/log/dsmsched.log
SCHEDLOGRETENTION       30
SCHEDMODE       PROMPTED
MANAGEDSERVICES WEBCLIENT SCHEDULE
* WEBPORTS 2123 2124
</pre>
Now create a new options file with:
```
nano /opt/tivoli/tsm/client/ba/bin/dsm.opt
```
Replace the bold entry and paste:
<pre>
************************************************************************
*                                                                      *
* Sample Client User Options file for UNIX (dsm.opt.smp)               *
************************************************************************

*  This file contains an option you can use to specify the
*  server to contact if more than one is defined in your client
*  system options file (dsm.sys).  Copy dsm.opt.smp to dsm.opt.
*  If you enter a server name for the option below, remove the
*  leading asterisk (*).

************************************************************************

SERVERNAME	<b>TSM-SERVERNAME</b>
SUbdir          yes
QUIET
DOMAIN ALL-LOCAL
* DOMAIN "/"
* DOMAIN "/home"
</pre>

### Starting the TSM backup

To start the TSM backup simply type:
```
sudo dsmc incremental
```
You may get asked for the TSM password. You can find the complete documentation of all command line parameter [here].
  [IBM support site]: http://www-01.ibm.com/support/docview.wss?uid=swg24042956
  [HU configuration manual]: https://www.cms.hu-berlin.de/de/dl/systemservice/fileservice/tsm/konfiguration/tsm-client-linux
  [here]: https://www.ibm.com/support/knowledgecenter/en/SSGSG7_6.4.0/com.ibm.itsm.client.doc/t_bac_cmdline.html
