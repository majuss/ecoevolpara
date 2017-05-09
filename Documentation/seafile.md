# Seafile

Seafile is a program which enables us to host our own cloud system very much like Dropbox, iCloud or Onedrive. The mainthought behind it, is to synchronize all *home* directories between harriet, beagle and all clients like the Dell Optiplex and the Intel NUCs. This will enable every user to log into any client computer and syncs their homes to it.

On the Client site there are 2 major branches. First of all there is Harriet, who synces the home directories through the seaf-cli client which runs individually for every user on Harriet. On the normal clients every user can simply use the gui client or he can setup the cli client if desired.

The domain of the seafile server is `svalbard.biologie.hu-berlin.de`. It’s now available even outside of the HU-network, you don’t need to use the VPN anymore.

## Setting up a client on Linux

### Debian GUI

It’s recommended to use our [custom Installer] for the Seafile-Client (GUI or CLI).

#### With installer

1.  Download the installer from above.
2.  Run it in the terminal (open it with the search function) with `sudo bash install_seafile_client.sh`. You need [sudo-privileges for this].
3.  Choose graphical client. And follow the instructions.
4.  Search for `seafile` and start it.
5.  In the first field enter the path: `/home/seafile/your_username`
6.  In the next field, enter our server-url: `https://svalbard.biologie.hu-berlin.de`, your Seafile user-email and password (both provided by the workgroup-admin).
7.  When Seafile starts up right click in Seafile your *home\_your\_username* and choose `sync this library` then click `sync with an existing folder` and enter the path to your home (/home/marius).
8.  Add Seafile to the autostart see [here].


---
**Sync a shared directory**

You can not sync a shared folder into your home directory. Thats why the installer created the directory */home/shared/your_username*. You can sync your shared directories into that directory.

---


#### Without installer

To install the seafile-client you need [sudo-privileges].

First you need to update your operating system: :: sudo aptitude update sudo aptitude upgrade

After that add the key of the Seafile-repo:  
`sudo apt-key adv –keyserver hkp://keyserver.ubuntu.com:80 –recv-keys 8756C4F765C9AC3CB6B85D62379CE192D401AB61`  
Then add the repo itself with:  
`echo deb <http://dl.bintray.com/seafile-org/deb> jessie main | sudo tee /etc/apt/sources.list.d/seafile.list`  
Replace jessie with the Debian release you’re using (`lsb_release -a | grep Codename`). Then run an update of the package-list.  
`sudo aptitude u

  [sudo-privileges]: INSERT LINK
  [here]: INSERT LINK
  [custom Installer]: INSERT LINK