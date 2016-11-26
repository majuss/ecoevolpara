*******
Seafile
*******


Seafile is a program which enables us to host our own cloud system very much like Dropbox, iCloud or Onedrive. The mainthought behind it, is to synchronize all /home/ directories between harriet, beagle and all clients like the Dell Optiplex and the Intel NUCs. This will enable every user to log into any client computer and syncs their homes to it.

================================
Setting up the Server (Svalbard)
================================


The Server on which all seafile data is stored is Svalbard. On Svalbard a user named seafile drives the seafile-server software.

On the Client site there are 2 major branches. First of all there is harriet, who synces the home directories through the seaf-cli client which runs individually for every user on harriet. On the normal clients every user can simply use the gui client or he can setup the cli client if desired.

To set up the seafile-gui client on a normal client computer with a clean debian install you need to first of all download it via aptitude, after adding the repo and key (LINK TO DL). When an error occurs while installing which includes the libssl1.0.0 you need to google the package for debian, download, and install it via dpkg -i.

After installing it you have to add a global environment variable for the config file, because seafile can't sync sirectories which contain the config(".ccnet") directory so you have to make sure it gets stored at a different place with the env. variable.
::
    export CCNET_CONF_DIR=/etc/seafile/$USER
    
 in /etc/profile will create the variable for every user in the according directory. Now you have to create the directories for every user.

A seafile-ignore.txt should be included in every Library you wish to sync, espacially inside of the homes. The file should contain a wild card for all dot-files/directories. You should also exclude a directory which includes all github projects, to avoid sync conflicts with git.

===================================
Setting up the home-sync on Harriet
===================================

===================
Setting up a client
===================
