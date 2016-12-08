*******
Seafile
*******


Seafile is a program which enables us to host our own cloud system very much like Dropbox, iCloud or Onedrive. The mainthought behind it, is to synchronize all /home/ directories between harriet, beagle and all clients like the Dell Optiplex and the Intel NUCs. This will enable every user to log into any client computer and syncs their homes to it.


On the Client site there are 2 major branches. First of all there is Harriet, who synces the home directories through the seaf-cli client which runs individually for every user on Harriet. On the normal clients every user can simply use the gui client or he can setup the cli client if desired.


The domain of the seafile server is :code:`svalbard.biologie.hu-berlin.de`. Ìt's only available inside of the HU-network. This means to download and upload files from our cloud you need to have a working VPN connection when you're located outside the HU.

================================
Setting up the Server (Svalbard)
================================

The Server on which all seafile data is stored is Svalbard. On Svalbard a user named seafile drives the seafile-server software.

Setting up the server can be devided into 4 steps
* Installing and setting up a MySQL database
* Downloading and instlling the server-software
*

Steps here will only describe the procedure briefly since it will likely be completely different when the sever needs a new setup.




To set up the seafile-gui client on a normal client computer with a clean debian install you need to first of all download it via aptitude, after adding the repo and key (LINK TO DL). When an error occurs while installing which includes the libssl1.0.0 you need to google the package for debian, download, and install it via dpkg -i.

After installing it you have to add a global environment variable for the config file, because seafile can't sync sirectories which contain the config(".ccnet") directory so you have to make sure it gets stored at a different place with the env. variable.
::
    export CCNET_CONF_DIR=/etc/seafile/$USER
    
 in /etc/profile will create the variable for every user in the according directory. Now you have to create the directories for every user.

A seafile-ignore.txt should be included in every Library you wish to sync, espacially inside of the homes. The file should contain a wild card for all dot-files/directories. You should also exclude a directory which includes all github projects, to avoid sync conflicts with git.


------------------------------
Acquiring HTTPS for the domain
------------------------------


Cut certs into chain. Get root cert from hu site

---------------------------------------
Setting up init.d to control the server
---------------------------------------

Copy the file from 

Create a new file under /etc/init.d/seafile with vim or nano.

Now you can control the server with commands like:
::
	/etc/init.d/seafile stop



===================================
Setting up the home-sync (Harriet)
===================================


Do lots of stuff


===================
Setting up a client
===================

----------
Debian GUI
----------

It is recommended to use our custom :download:`Installer <appendix/scripts/install_seafile_client.sh>` for the Seafile-Client (GUI or CLI) `

^^^^^^^^^^^^^^
With Installer
^^^^^^^^^^^^^^

1. Download the installer from above.
2. Run it with :code:`sudo bash install_seafile_client.sh`. You need sudo-privealeges for this, or you login in as root with :code:`su root`.
3. Choose graphical client.
4. Enter your short username.
5. Choose 1 and restart all window-servers.
6. Search for :code:`seafile` and start it.
7. In the first field choose the path: :code:`/home/seafile/$uername`
8. In the next field, enter our server-url: :code:`https://svalbard.biologie.hu-berlin.de`, your user-email and password.
9. When seafile starts up right click your home_$username and choose :code:`existing folder` and enter the path to your home.


^^^^^^^^^^^^^^^^^
Without installer
^^^^^^^^^^^^^^^^^

To install the seafile-client you need root-privealeges. First add the key of the seafile-repo:
::
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 8756C4F765C9AC3CB6B85D62379CE192D401AB61
Then add the repo itself with:
::
	echo deb http://dl.bintray.com/seafile-org/deb jessie main | sudo tee /etc/apt/sources.list.d/seafile.list
Replce jessie with the Debian release you're using.
Then run an update of the package-list.
::
	sudo aptitude update
And finally install the Client:
::
	sudo aptitude install seafile-gui

For the official manual see: `Seafile-manual on github <https://github.com/haiwen/seafile-user-manual/blob/master/en/desktop/install-on-linux.md>`_.


----------
Debian CLI
----------

^^^^^^^^^^^^^^
With installer
^^^^^^^^^^^^^^

1. Download the installer from :download:`here <appendix/scripts/install_seafile_client.sh>`
2. Run it with :code:`sudo bash install_seafile_client.sh`. You need sudo-privealeges for this, or you login in as root with :code:`su root`.
3. Choose cli client.
4. Enter your local short username.
5. Enter your seafile login email.
6. Enter your seafile login password.
7. Enter the local directory you want to sync (/home/marius for example).
8. Enter the seafile library ID. You get this ID if you log into seafile online, click onto the library and copy the ID out of the URL.


^^^^^^^^^^^^^^^^^
Without installer
^^^^^^^^^^^^^^^^^

You need the Library IDs of every Library you want to sync. You get it by opening seafile in a browser, open the library and copy it from the URL-bar.

Follow the steps above for the GUI-client till the :code:`aptitude install`. For the CLI-client type:
::
	sudo aptitude install seafile-cli

After installing the client you need to create several directories outside of your home directory to have a place where seafile can store the configuration files.


Don't alter :code:`$USER` and :code:`currentuser`since it will grab the current user which is logged in automatically
::
	currentuser=$USER
	sudo mkdir /home/seafile/$currentuser
	sudo mkdir /etc/seafile_confs/$currentuser
	sudo chown $USER:$currentuser /home/seafile/$currentuser
	sudo chown $USER:$currentuser /etc/seafile_conf/$currentuser



seaf-cli init -c /etc/seafile_confs/$USER -d /home/seafile/$USER
seaf-cli start -c /etc/seafile_confs/$USER
seaf-cli sync -l  -s https://svalbard.biologie.hu-berlin.de -u $Username -p $Password -c /etc/seafile_confs/$USER -d /home/$USER

With 

Downloading seafile-cli-init.sh



https://manual.seafile.com/



https://manual.seafile.com/deploy/using_mysql.html

https://manual.seafile.com/deploy/deploy_with_nginx.html

https://manual.seafile.com/deploy/https_with_nginx.html

https://github.com/haiwen/seafile-user-manual/blob/master/en/desktop/install-on-linux.md






============================
Updating the server-software
============================

Login as the user seafile with :code:`sudo su seafile` and stop the running server with :code:`/etc/init.d/seafile stop`. Then run the minor-upgrade script: :code:`bash /usr/local/bin/seafile-server/seafile-server-6.0.5/upgrade/minor-upgrade.sh`



