******
Debian
******

Debian is a common and completely free Linux distribution. It is released in 3 release-branches. Stable, stretch and experimental. We are using the stretch release, since debian-stable is very conservtive and updates getting rolled out pretty slow.

Administrator / Root privileges
===============================

Normal users don't have the privileges to install software and change system configurations like adding printers. The so called :code:`root` user is the administrator. You can change to that user with :code:`su root` if you know the password. Otherwise we use the program :code:`sudo` to provide normal users admin privs without using the user root directly. The privileged users are entered in :code:`visudo` with a line like that :code:`victor ALL=(ALL:ALL) ALL`.

Victor then have the privs to call a program as administrator (root) with the :code:`sudo command`.

.. warning::

   Never run unnecessarily programs as root. Such as :code:`git` or you bioinfromatical pipelines. You can actually damage the servers integrity.

INSERT WARNING

Install software
================

First look if you can find the software you are looking for in the official debian repositories with:
::
    aptitude search $softwarename

This will list all findings, if nothing get's posted your software is not inside the official repos. Then you have to evaluate if you really need this software... When you really need it google for a download link. You should go for a package with the ending ".deb" which indicates a debian package. Often these packages are listed under Ubuntu, since Ubuntu is a Debian-derivate.

If the search finds your desired software you can easily install it via:
::
    aptitude install $softwarename

Update and upgrade Debian
=========================

::
    aptitude update

Will update the package list/cache. Always run this before you upgrading or installing software!
::
    aptitude upgrade

Will upgrade all packages which are outdated.

Software that needs regular manual updates
------------------------------------------
- seafile server
- rstudio server


Connect to a server via ssh
===========================

On the client machine you have to create ssh keys with:
::
	ssh-keygen

Then cat the created id_rsa.pub key:
::
	cat ~/.ssh/id_rsa.pub

Copy the output. Now you need a already working connection to the server or you send the key to someone who can add it onto the server.
To add the key on the server run (replace $username with your actual username on the server):
::
	nano /home/$username/.ssh/authorized_keys

Paste the key onto the end of the file. If .ssh doesn't exist you can create it with :code:`mkdir`. Now test your ssh connection to the server.

.. tip::

    Create a ssh-config on your client machine with: :code:`nano ~/.ssh/config`. And enter the servers IP, username and a shortcut to quickly connect to your servers. It should look like this:::
    Host sw 				#shortcut
	HostName 192.168.178.1	#server IP
	User marius				#server username

	And then call it with :code:`ssh sw`.

Working with printers
=====================

If you want to add a printer you will need sudo privileges. Then run the printer-settings gui with:
::
	sudo system-config-printer

This will open a window where you can add a printer. Click "Add" and have a look at the list of network-printers. Mind the printers IP adress (there should be a sticker on the printer or you can look them up in the IP-mapping table).

Add programs to the autostart
=============================

Hit the windows-key and search for "startup", open the first search result "Startup Applications". Click on "Add" and choose your desired software.

.. figure:: appendix/pictures/startup1.jpg
   :width: 450px
   :alt: How to autostart a program