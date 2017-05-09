# Incremental backup


## Backup with R-diff backup

(outdated)

Our backup from harriet and its mounted fibrechannel-space SAN is realised with rdiff-backup (installed with: `aptitude install rdiff-backup`). The software has to be installed on the server and the machine which will get backed up. Additionally the server needs a working ssh-connection to all clients. This means you have to store the pub-key from the server on every client in /root/.ssh/authorized\_keys. See 2.3.2 for the description of the cronjob which will trigger the backup.

The user rdiff-backup will connect via a root-ssh connection but onto the key in /root/.ssh/authorized\_keys we will append: :: command=“rdiff-backup –server –restrict-read-only /”,from=“141…”,no-port-forwarding,no-X11-forwarding,no-pty ssh-rsa AAAAB3Nz..

This will only allow rdiff-backup commands through this conenction in read-only and only coming from svalbards IP.

To restore any file from harriet you first have to login as the user rdiff-backup (password is found in the KeePassX-database), then you have to type:
```
rdiff-backup -r $days_to_go_back $path_to_file_to_restore $targed_path
```
So for example to restore alices whole home directory from 10 days ago:
```
rdiff-backup -r 10D /data/backup/harriet/localstorage/alice /data/backup/restore/alice
```
The directory has to be owned by rdiff-backup so the user can write into it.

To delete old increments run: `rdiff-backup –remove-older-than 90D /data/backup/harriet` This will delete all increments which are older than 90 days.



How to setup: <https://www.howtoforge.com/linux_rdiff_backup>


## TSM-backup

 IBM Tivoli Storage Manager is a heavy backup software which enables clients to upload their backup onto TSM servers. TSM is now called IBM Spectrum Protect. We have the authorization to backup our server onto the HU TSM servers.

### Installing the client software

Installing the client server on a Debian system running kernel 4.9+ is somewhat complicated. You need several `.deb` packages to install the software.


1. Create a working directory and change into it: `mkdir tsm; cd tsm`

2. Download the latest `.deb` package from: http://www-01.ibm.com/support/docview.wss?uid=swg24042956 OR Direct link: 
```
wget: ftp://public.dhe.ibm.com/storage/tivoli-storage-management/maintenance/client/v8r1/Linux/LinuxX86_DEB/BA/v810/8.1.0.0-TIV-TSMBAC-LinuxX86_DEB.tar
```

3. Decompress the downloaded `.tar` archive: `tar -xvf 8.1.0.0-TIV-TSMBAC-LinuxX86_DEB.tar`

4. Delete the outdated Filepath source: `rm tivsm-filepath-source.tar.gz` for a Debian running Kernel 4.9.0-2 you can download this Filepath source: INSERT FILEPATH SOURCE LINK. For any other Kernel you can try the above, or the one inside the `.tar` package. If they don't compile you have to write an E-Mail to IBM-staff (tsmosreq@us.ibm.com).

5. Check the release number of your TSM instance: `dpkg-deb -I tsmbackup/tivsm-api64.amd64.deb` and copy the `Version:` entry.

6. Install `make` and the Linux-headers: 
```
sudo aptitude update
sudo aptitude install build-essential linux-headers-amd64
```


Then extract the Filepath source: `tar -xf TIVsm-filepath-source_test.tar.gz`. Change into source directory: `cd jbb_gpl` and compile it with `make RELNUM=$copiedReleaseNumber deb`. If the compile can't finish successfull you can't continue, see step 4 for details. If `make` is not found you first have to run `sudo aptitude update` and then `sudo aptitude install build-essential linux-headers-amd64`.

7. 

```
sudo dpkg -i gskcrypt64_8.0-50.40.linux.x86_64.deb gskssl64_8.0-50.40.linux.x86_64.deb
sudo dpkg -i tivsm-api64.amd64.deb
sudo dpkg -i tivsm-ba.amd64.deb
sudo dpkg -i tivsm-bacit.amd64.deb
sudo dpkg -i tivsm-jbb.amd64.deb
sudo dpkg -i tivsm-bahdw.amd64.deb
```



### TSM Configuration

alter init.d file 

//Hu configuration doc
https://www.cms.hu-berlin.de/de/dl/systemservice/fileservice/tsm/konfiguration

### Starting the TSM backup

// commandline doc
https://www.ibm.com/support/knowledgecenter/en/SSGSG7_6.4.0/com.ibm.itsm.client.doc/t_bac_cmdline.html



