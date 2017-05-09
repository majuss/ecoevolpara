Geneious
========

A lot of members of the institute are using a software called “geneious” to analyse DNA-data. We have 6 licenses which are only compatible with the version 6.1.8 (you can get this old version [here]). The server providing the licenses is Beagle. Additionally to the license server, Beagle is running a mysql server, which provides the “shared database” for all geneious-users at the institute.

Setting up a Geneious client
----------------------------

### macOS

1.  [Download the macOS-client.] Double click the .dmg to mount it.
2.  Copy the Geneious.app to your Applications directory. Start Geneious. At the window which popped up click “Activate a license”. Click on “Use floating license server”. Now enter the credentials you got from the administrator.

### Windows

1.  [Download the Windows-client]
2.  Double click the .exe and click through the installer. When it’s finished start Geneious, a window will pop up. Click on “Activate a license”. Click on “Use floating license server”. Now enter the credentials you got from the administrator.

### Linux

1.  [Download the Linux-client]
2.  Run it with code: sudo bash ~/Downloads/Geneious\_linux64\_6\_1\_8\_with\_jre.sh and click through the suggested parameter.
3.  Now type “geneious” into the search and start it. At the window which popped up click “Activate a license”. Click on “Use floating license server”. Now enter the credentials you got from the administrator.

## Log into the shared Database

1.  Start Geneious and right click onto **Shared Database** on the left hand side and click **Connect to a set up database**.
2.  Type into the username, password, Host. The database-name is **geneiousDB** and the **Port 3306**. For the database vendor choose MySQL. Then click on **More Options** and click the **Browse** button behind “Driver .jar file:” choose [this file].
3.  Click “Ok”, you are now connected to the shared database.

## Set up the Geneious License Server (Beagle)

This Tutorial will guide you from the start to set up the geneious license server on a completely new machine. It requires you in the first place to create a virtual machine with Debian stable. Stable because in the later releases, software which is required by the geneious license server was removed from Debian. So you need an Debian running a 3.X Kernel or earlier.

Inside of the Debian stable VM you need to download the [server software]. Then start the scr
  [this file]: https://github.com/majuss/ecoevolpara/raw/master/source/appendix/various/geneious/mysql-connector-java-5.1.30-bin.jar
  [here]: http://www.geneious.com/previous-versions/
  [Download the macOS-client.]: https://assets.geneious.com/installers/geneious/release/Geneious_mac64_6_1_8.dmg
  [Download the Windows-client]: https://assets.geneious.com/installers/geneious/release/Geneious_win64_6_1_8_with_jre.exe
  [Download the Linux-client]: https://assets.geneious.com/installers/geneious/release/Geneious_linux64_6_1_8_with_jre.sh
  [server software]: http://www.geneious.com/installers/licensingUtility/2_0_3/GeneiousLicenseServer_linux64_2_0_3_with_jre.sh/