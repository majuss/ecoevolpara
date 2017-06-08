# Custom cronjobs

You can look at the cronjobs with `sudo crontab -e`. The scripts which get triggered by these jobs are usually located in `/usr/local/bin`. Make sure the scripts are executable (`chmod +x`).

```
00 01 * * 7 [ $(date +%d) -le 07 ] && /usr/local/bin/btrfs_scrub.sh
00 12 * * 7 [ $(date +%d) -le 07 ] && /usr/local/bin/maintenance_svalbard.sh
```

## Update blastdb nt, nr and taxdb (Harriet, Beagle)

```
00 03 * * 6 [ $(date +\%d) -le 06 ] && /usr/local/bin/update_blastdb_cron.sh
```

This cronjob will download the most recent blast databases *nt*, *nr* and *taxdb* with `wget` over ftp. The script auomatically store the old dbs marked with a timestamp in a directory called `old.blastdb`. It is currently installed on Beagle and Harriet and will run once on the first saturday off each month. This job is located in `/usr/local/bin`.

## Backup with rdiff-backup (Svalbard)
```
00 00 * * *  /bin/bash /usr/local/bin/rdiff-backup.sh
```

This cronjob simply trigger the `rdiff-backup.sh` script at 3:00 each day which is usually located in `/usr/local/bin` on Svalbard.

## btrfs scrubbing (Beagle, Harriet, Svalbard)

```
00 01 * * 7 [ $(date +\%d) -le 07 ] && /usr/local/bin/btrfs_scrub.sh
```

This cronjob is starting a scrub every month on the first sunday at 01:00 by run the script `btrfs_scrub.sh` located in `/usr/local/bin`

## Starting geneious VM (beagle)
```
@reboot /usr/local/bin/geneiousvm.sh
```

This cronjob will start a QEMU command to start the virtual machine running the [geneious](Geneious license server). This license server is running in the vm due to incompatibilities with modern system libraries. Never update this VM!

## Maintenance report over Slack (Beagle, Harriet, Svalbard)
```
@monthly /bin/bash /usr/local/bin/maintenance_report.sh
```
This job requires a setted up slack bot, `smartmontools` and `sensors`

This job will post a maintenance report every month.

To set this job and script up on a complete new Debian and btrfs driven server you have to install `smartmontools` then you have to get a Slack API key, a setted up Slack-bot and a channel

## Zoetero-bot

```
@reboot /bin/bash /usr/local/bin/zotero-bot.sh
```


## Starting Windows VMs on Svalbard
```
@reboot /bin/bash /usr/local/bin/vm_start.sh
```


## TSM backup
```
@weekly /usr/bin/dsmc incremental
```

Executes the TSM-backup every week.


    [geneious]: https://majuss.gitbooks.io/ecoevolpara/Documentation/geneious.html#geneious