***************
Custom cronjobs
***************

You can look at the cronjobs with crontab -e. The scripts which get triggered by these jobs are usually located in /usr/local/bin. Make sure the scripts are executable (chmod +x).


Example:
::
    00 01 * * 7 [ $(date +\%d) -le 07 ] && /usr/local/bin/btrfs_scrub.sh
    00 12 * * 7 [ $(date +\%d) -le 07 ] && /usr/local/bin/maintenance_svalbard.sh`

=================================================
Update blastdb nt, nr and taxdb (Harriet, Beagle)
=================================================

This cronjob will download the actual blast databases nt and nr with wget over ftp. The script auomatically store the old dbs marked with a timestamp in a directory called old.blastdb. It is currently installed on beagle for testing purposes only and will run once on the first saturday off each month. This job is located in /usr/local/bin.

===================================
Backup with rdiff-backup (Svalbard)
===================================

This cronjob simply trigger the rdiff-backup.sh script at 3:00 each day which is usually located in /usr/local/bin on svalbard.

===========================================
btrfs scrubbing (Beagle, Harriet, Svalbard)
===========================================

This cronjob is starting a scrub every month on the first sunday at 01:00 by run the script $insertscriptname located in /usr/local/bin

=============================
Starting geneious VM (beagle)
=============================

This cronjob will start a QEMU command to start the virtual machine running the Geneious license server. This license server is running in the vm due to incompatibilities with modern system libraries. Never update this vm!


For furthy documentation about vm check x.x. or 2.4 for information on Geneious.

=========================================================
Maintenance report over Slack (Beagle, Harriet, Svalbard)
=========================================================

This job will post a maintenance report every first sunday at 12:00.

To set this job and script up on a complete new Debian and btrfs driven server you have to install smartctl. Slack API key, Slack-bot and a channel
