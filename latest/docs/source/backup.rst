******************
Incremental backup
******************

Our backup from harriet and its mounted fibrechannel-space SAN is realised with rdiff-backup (installed with: :code:`aptitude install rdiff-backup). The software has to be installed on the server and the machine which will get backed up. Additionally the server needs a working root ssh-connection to all clients. This means you have to store the pub-key from the server on every client in /root/.ssh/authorized_keys. See 2.3.2 for the description of the cronjob which will trigger the backup.

To restore any file from harriet you first have to login as the user rdiff-backup (password is "---"), then you have to type:
::
    
    rdiff-backup -r $days_to_go_back $file_to_restore $targed_path

So for example to restore alices whole home director from 10 days ago:
::
    
    rdiff-backup -r 10D /data/backup_harriet/localstorage/alice /data/backup_restore/alice

The directory has to be owned by rdiff-backup so the user can write into it.