# Debian

Debian is a common and completely free Linux distribution. It is released in 3 release-branches: *stable*, *testing* and *experimental*. We are using the *testing* release, since debian-stable is very conservative and updates getting rolled out pretty slow.

## <a name="sudo"></a>Administrator / Root privileges

Normal users don’t have the privileges to install software and change system configurations like adding printers. The so called `root` user is the administrator. You can change to that user with `su root` if you know the password. Otherwise we use the program `sudo` to provide normal users admin privs without using the user root directly. The privileged users are entered in `visudo` with a line like that `victor ALL=(ALL:ALL) ALL`.

Victor then have the privs to call a program as administrator (root) with the `sudo command`.

**Never run programs as root unnecessary** such as `git` or you bioinformatical pipelines. You can actually **damage the servers** integrity.

## Install software

First look if you can find the software you are looking for in the official debian repositories with:
```
aptitude search $softwarename
```
This will list all findings, if nothing get’s posted your software is not inside the official repos. Then you have to evaluate if you really need this software… When you really need it google for a download link. You should go for a package with the ending “.deb” which indicates a debian package. Often these packages are listed under Ubuntu, since Ubuntu is a Debian-derivate.

If the search finds your desired software you can easily install it via:
```
sudo aptitude install $softwarename
```

---
**If Aptitude is not installed...**
... you first need to install Aptitude with the command `sudo apt-get install aptitude`.

---

## Update and upgrade Debian
-------------------------

It is recommended to update and upgrade the system regulary.
```
sudo aptitude update
```
Will update the package list/cache. Always run this before you upgrading or installing software!
```
sudo aptitude upgrade
```
Will upgrade all packages which are outdated.

### Software that needs regular manual updates

-   [Seafile server]
-   [RStudio server]

## Connect to a server via ssh

On the client machine you have to create ssh keys with: `ssh-keygen`

Then cat the created id_rsa.pub key: `cat ~/.ssh/id_rsa.pub`

Copy the output. Now you need a already working connection to the server or you send the key to someone who can add it onto the server. To add the key on the server run (replace $username with your actual username on the server): `nano /home/$username/.ssh/authorized_keys`

Paste the key onto the end of the file. If `.ssh` doesn’t exist you can create it with `mkdir`. Now test your ssh connection to the server.


---
**Tip to connect quickly**

Create a ssh-config on your client machine with: `nano ~/.ssh/config`. And enter the servers IP, username and a shortcut to quickly connect to your servers. To use the underneath config you simply would call `ssh h`.
```
Host h
HostName 192.168.178.1
User marius
```
---

## Working with printers

If you want to add a printer you will need **sudo privileges**. Then run the printer-settings gui with:
```
sudo system-config-printer
```
This will open a window where you can add a printer. Click **Add** and have a look at the list of network-printers. Mind the printers IP adress (there should be a sticker on the printer or you can look them up in the IP-mapping table).

## Add programs to the autostart WORK IN PROGRESS - PICTURES BROKEN

INSERT RIGHT PICTURES

Hit the windows-key and search for "startup", open the first search result "Startup Applications".

    [link]: https://majuss.gitbooks.io/ecoevolpara/Documentation/debian_test.html#administrator--root-privileges
    [Seafile server]: https://www.seafile.com/en/download/#server
    [RStudio server]: https://www.rstudio.com/products/rstudio/download-server/