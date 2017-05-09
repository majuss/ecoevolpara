KeePassX
========

KeePassX is an open source multiplatform password management program. You decrypt your database file with a masterpassword (and an optional key) and get access to all your saved user-credentials.

Installing on Linux
-------------------

KeepassX is getting delivered in 2 different versions depending on your Linux distribution (as you can see here: `https://packages.debian.org/search?keywords=keepassx`). The Debian stable release (Jessie) is only getting the old version of KeePassX 0.4.3. The testing release (Stretch) is getting the latest verison 2.0.3. It’s highly recommended to only use the modern version 2.X to preserve compatibility.

First of all you have to determine which Linux you’re running by execute: `cat /etc/os-release | grep VERSION`. If the output says `stretch` you’re good to go to just install it with `sudo aptitude install keepassx`. If it says `jessie` jump to the next step.

### Installing KeePassX via backports

Add: `deb http://ftp.debian.org/debian jessie-backports main` to `/etc/apt/sources.list` to get packages from newer Debian distributions while running the stable release.

Then run: :: sudo apt-get update sudo aptitude -t jessie-backports install keepassx

This will install the latest KeePassX version on Jessie (stable).

If you previously installed the 0.4.3 version just uninstall it with: `sudo aptitude purge keepassx`.

Installing on Windows
---------------------

Just visit the website and download the KeePassX installer: [KeePassX website:].

Installing on macOS
-------------------

Just visit the website and download the KeePassX diskimage: [KeePassX website:].

  [KeePassX website:]: https://www.keepassx.org/downloads