Incremental backup
==================

(outdated)

Our backup from harriet and its mounted fibrechannel-space SAN is realised with rdiff-backup (installed with: `aptitude install rdiff-backup`). The software has to be installed on the server and the machine which will get backed up. Additionally the server needs a working ssh-connection to all clients. This means you have to store the pub-key from the server on every client in /root/.ssh/authorized\_keys. See 2.3.2 for the description of the cronjob which will trigger the backup.

The user rdiff-backup will connect via a root-ssh connection but onto the key in /root/.ssh/authorized\_keys we will append: :: command=“rdiff-backup –server –restrict-read-only /”,from=“141…”,no-port-forwarding,no-X11-forwarding,no-pty ssh-rsa AAAAB3Nz..

This will only allow rdiff-backup commands through this conenction in read-only and only coming from svalbards IP.

To restore any file from harriet you first have to login as the user rdiff-backup (password is found in the KeePassX-database), then you have to type: :: rdiff-backup -r $days\_to\_go\_back $file\_to\_restore $targed\_path

So for example to restore alices whole home director from 10 days ago: :: rdiff-backup -r 10D /data/backup\_harriet/localstorage/alice /data/backup\_restore/alice

The directory has to be owned by rdiff-backup so the user can write into it.

To delete old increments run: :: rdiff-backup –remove-older-than 90D /data/backup\_harriet This will delete all increments which are older than 90 days.

How to setup: <https://www.howtoforge.com/linux_rdiff_backup>