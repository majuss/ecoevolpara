*******
Seafile
*******


Seafile is a program which enables us to host our own cloud system very much like Dropbox, iCloud or Onedrive. The mainthought behind it, is to synchronize all *home* directories between harriet, beagle and all clients like the Dell Optiplex and the Intel NUCs. This will enable every user to log into any client computer and syncs their homes to it.


On the Client site there are 2 major branches. First of all there is Harriet, who synces the home directories through the seaf-cli client which runs individually for every user on Harriet. On the normal clients every user can simply use the gui client or he can setup the cli client if desired.


The domain of the seafile server is :code:`svalbard.biologie.hu-berlin.de`. It's only available inside of the HU-network. This means to download and upload files from our cloud you need to have a working `VPN connection <http://ecoevolpara.readthedocs.io/en/latest/vpn.html>`_ when you're located outside the HU.


Setting up a client
===================

Debian GUI
----------

It's recommended to use our custom :download:`Installer <appendix/scripts/install_seafile_client.sh>` for the Seafile-Client (GUI or CLI). If you want to use Seafile outside of the HU-network you need a HU-Account and a working `VPN connection <http://ecoevolpara.readthedocs.io/en/latest/vpn.html>`_.

With installer
^^^^^^^^^^^^^^

1. Download the installer from above.
2. Run it in the terminal (open it with the search function) with :code:`sudo bash install_seafile_client.sh`. You need `sudo-privileges for this <http://ecoevolpara.readthedocs.io/en/latest/Debian.html#administrator-root-privileges>`_.
3. Choose graphical client. And follow the instructions.
4. Search for :code:`seafile` and start it.
5. In the first field enter the path: :code:`/home/seafile/your_username`
6. In the next field, enter our server-url: :code:`https://svalbard.biologie.hu-berlin.de`, your Seafile user-email and password (both provided by the workgroup-admin).
7. When Seafile starts up right click in Seafile your *home_your_username* and choose :code:`sync this library` then click :code:`sync with an existing folder` and enter the path to your home (/home/marius).
8. Add Seaflie to the autostart see `here <http://ecoevolpara.readthedocs.io/en/latest/Debian.html#add-programs-to-the-autostart>`_.

Without installer
^^^^^^^^^^^^^^^^^

To install the seafile-client you need `sudo-privileges<http://ecoevolpara.readthedocs.io/en/latest/Debian.html#administrator-root-privileges>`_.

First you need to update your operating system:
::
	sudo aptitude update
	sudo aptitude upgrade

After that add the key of the Seafile-repo:
::
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 8756C4F765C9AC3CB6B85D62379CE192D401AB61
Then add the repo itself with:
::
	echo deb http://dl.bintray.com/seafile-org/deb jessie main | sudo tee /etc/apt/sources.list.d/seafile.list
Replace jessie with the Debian release you're using (:code:`lsb_release -a | grep Codename`).
Then run an update of the package-list.
::
	sudo aptitude update
And finally install the Client:
::
	sudo aptitude install seafile-gui

Then export the needed environment variable with:
::
	sudo echo -e "CCNET_CONF_DIR\t DEFAULT=/etc/seafile/$USER" >> /home/$USER/.xsessionrc
Create needed directories for the config and own them:
::
	sudo mkdir /home/seafile /home/seafile/$USER /etc/seafile /etc/seafile/$USER
	sudo chown $USER:$USER /home/seafile/$USER /etc/seafile/$USER

Log out of your x-server and back in with:
::
	sudo /etc/init.d/lightdm restart
	sudo /etc/init.d/gdm restart

Now follow the manual with the installer `above from step 4 <http://ecoevolpara.readthedocs.io/en/latest/Seafile.html#with-installer>`_.


For the official manual see: `Seafile-manual on github <https://github.com/haiwen/seafile-user-manual/blob/master/en/desktop/install-on-linux.md>`_.

Debian CLI
----------

With installer
^^^^^^^^^^^^^^

1. Download the installer from :download:`here <appendix/scripts/install_seafile_client.sh>`
2. Run it with :code:`sudo bash install_seafile_client.sh`. You need `sudo-privileges<http://ecoevolpara.readthedocs.io/en/latest/Debian.html#administrator-root-privileges>`_ for this.
3. Choose cli client.
4. Enter your local short Debian username.
5. Enter your Seafile login email.
6. Enter your Seafile login password.
7. Enter the local directory you want to sync (/home/marius for example).
8. Enter the Seafile library ID. You get this ID if you log into Seafile via a browser, click onto the library and copy the ID out of the URL.
9. Add a cronjob to :code:`crontab -e` to run the client after a reboot: :code:`@reboot bash /usr/local/bin/seafile_startup/start_$USER.sh`

Without installer
^^^^^^^^^^^^^^^^^

You need the Library IDs of every Library you want to sync. You get it by opening Seafile in a browser, open the library and copy it from the URL-bar.

To install the Seafile-cli-client you need `sudo-privileges<http://ecoevolpara.readthedocs.io/en/latest/Debian.html#administrator-root-privileges>`_.

First you need to update your operating system:
::
	sudo aptitude update
	sudo aptitude upgrade

Install :code:`dirmngr` which enables you to add the Seafile rep.
::
	sudo aptitude install dirmngr

After that add the key of the Seafile-repo:
::
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 8756C4F765C9AC3CB6B85D62379CE192D401AB61
Then add the repo itself with:
::
	echo deb http://dl.bintray.com/seafile-org/deb jessie main | sudo tee /etc/apt/sources.list.d/seafile.list
Replace jessie with the Debian release you're using (:code:`lsb_release -a | grep Codename`).
Then run an update of the package-list.
::
	sudo aptitude update

Download libssl1.0, which is required by the client, and install it:
::
	wget http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u6_amd64.deb
	sudo dpkg -i libssl1.0.0_1.0.1t-1+deb8u6_amd64.deb

To install the CLI-client type:
::
	sudo aptitude install seafile-cli

After installing the client you need to create several directories outside of your home directory to have a place where Seafile can store the configuration files.
::
	sudo mkdir -p /home/seafile /home/seafile/$USER /etc/seafile/$USER /usr/local/bin/seafile_startup

Then you need to change the permissions:
::
	sudo chown $USER:$USER /home/seafile/$USER /etc/seafile/$USER

Now download the ignore-list to the local directory you want to sync:
::
	wget https://raw.githubusercontent.com/majuss/ecoevolpara/master/latest/docs/source/appendix/scripts/seafile-ignore.txt -P /home/$USER

Initialise the seafile-client with:
::
	seaf-cli init -c /etc/seafile/$USER/conf_dir -d /home/seafile/$USER
	seaf-cli start -c /etc/seafile/$USER/conf_dir
	seaf-cli sync -l "$seafile_library_id" -s https://svalbard.biologie.hu-berlin.de -d "$local_directory_to_sync" -c /etc/seafile/$USER/conf_dir -u "$seafile_login_email" -p "$login_password"

Save a startup script and setup a cronjob
::
	sudo echo -e "seaf-cli start -c /etc/seafile/$USER/conf_dir" > /home/$USER/start_$USER.sh
	sudo cp start_marius.sh /usr/local/bin/seafile_startup/
	sudo chown $USER:$USER /usr/local/bin/seafile_startup/start_$USER.sh
Run :code:`crontab -e` and enter:
::
	@reboot bash /usr/local/bin/seafile_startup/start_$your_username.sh

To check the status of the client run:
::
	seaf-cli status -c /etc/seafile/$USER/conf_dir

Setting up the Server (Svalbard)
================================

The Server on which all Seafile data is stored is Svalbard. On Svalbard a user named *seafile* drives the Seafile-server software.

Setting up the server can be devided into two steps:
- Installing and setting up a MySQL database
- Downloading and instlling the server-software

Steps here will only describe the procedure briefly since it will likely be completely different when the sever needs a new setup.

Acquiring HTTPS for the domain
------------------------------

Cut certs into chain. Get root cert from hu site

Setting up init.d to control the server
---------------------------------------

Copy the file from :download:`here <appendix/scripts/seafile-init.sh>`.

Create a new file under /etc/init.d/seafile with vim or nano and paste the content of the downloaded file into it and save.

Now you can control the server with commands like:
::
	/etc/init.d/seafile stop

Note that only the user seafile can actually control the server. If you don't get any response from the init.d command it wasn't successful.

See: https://manual.seafile.com/deploy/start_seafile_at_system_bootup.html

Setting up the home-sync (Harriet)
===================================


Do lots of stuff

Official Seafile Links:

https://manual.seafile.com/

https://manual.seafile.com/deploy/using_mysql.html

https://manual.seafile.com/deploy/deploy_with_nginx.html

https://manual.seafile.com/deploy/https_with_nginx.html

https://github.com/haiwen/seafile-user-manual/blob/master/en/desktop/install-on-linux.md


Setting up Seafile-WebDAV to sync attachements with Zotero
==========================================================

Does not work with nginx or apache. Reasons are unknown, you are getting an authentication error when you try to login in via the Zotero browser extension (every other client is working well).


Updating the server-software
============================

Login as the user seafile with :code:`sudo su seafile` and stop the running server with :code:`/etc/init.d/seafile stop`. Download the seafile-server-software from their site: https://www.seafile.com/en/download/ for example with: :code:`wget https://bintray.com/artifact/download/seafile-org/seafile/seafile-server_6.0.7_x86-64.tar.gz` then untar it: :code:`tar -xzf seafile-server_6.0.7_x86-64.tar.gz` and own it with :code:`sudo chown -R seafile:seafile seafile-server_6.0.7`. Copy the extracted directory to :code:`/usr/local/bin/seafile-server`. Then run the minor-upgrade script: :code:`bash /usr/local/bin/seafile-server/seafile-server-6.0.7/upgrade/minor-upgrade.sh`. After that start the server again with: :code:`/etc/init.d/seafile start` as the user seafile.

FAQ
===
- Q: CLI client failing with "ccnet-init not found..." A: look at the tutorial above, download the ccnet-init binary manually
- Q: no .ccnet directory found. A: you can't start seaf-cli without -c (confid dir)
- no root
- conflicts with system path
- screenshot log init failed
- the client indexing and uploading all the time and won't stop
