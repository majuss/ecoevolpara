Debian
======

Debian is a common and completely free Linux distribution. It is released in 3 release-branches. *Stable*, *stretch* and *experimental*. We are using the *stretch* release, since debian-stable is very conservtive and updates getting rolled out pretty slow.

Administrator / Root privileges
-------------------------------

Normal users don’t have the privileges to install software and change system configurations like adding printers. The so called `root` user is the administrator. You can change to that user with `su root` if you know the password. Otherwise we use the program `sudo` to provide normal users admin privs without using the user root directly. The privileged users are entered in `visudo` with a line like that `victor ALL=(ALL:ALL) ALL`.

Victor then have the privs to call a program as administrator (root) with the `sudo command`.

Never run unnecessarily programs as root. Such as `git` or you bioinfromatical pipelines. You can actually damage the servers integrity.

Install software
----------------

First look if you can find the software you are looking for in the official debian repositories with: :: aptitude search $softwarename

This will list all findings, if nothing get’s posted your software is not inside the official repos. Then you have to evaluate if you really need this software… When you really need it google for a download link. You should go for a package with the ending “.deb” which indicates a debian package. Often these packages are listed under Ubuntu, since Ubuntu is a Debian-derivate.

If the search finds your desired software you can easily install it via: :: aptitude install $softwarename

Update and upgrade Debian
-------------------------

It is recommended to update and upgrade the system regulary. :: aptitude update

Will update the package list/cache. Always run this before you upgrading or installing software! :: aptitude upgrade

Will upgrade all packages which are outdated.

### Software that needs regular manual updates

-   seafile server
-   rstudio server <https://www.rstudio.com/products/rstudio/download-server/>

Connect to a server via ssh
---------------------------

On the client machine you have to create ssh keys with: :: ssh-keygen

Then cat the created id\_rsa.pub key: :: cat ~/.ssh/id\_rsa.pub

Copy the output. Now you need a already working connection to the server or you send the key to someone who can add it onto the server. To add the key on the server run (replace $username with your actual username on the server): :: nano /home/$username/.ssh/authorized\_keys

Paste the key onto the end of the file. If .ssh doesn’t exist you can create it with `mkdir`. Now test your ssh connection to the server.

Create a ssh-config on your client machine with: `nano ~/.ssh/config`. And enter the servers IP, username and a shortcut to quickly connec