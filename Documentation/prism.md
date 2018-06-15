# Best: Don't use Prism, use R! The latter is much more powerful and makes it possible to fullfill the requirments of good scientific practice, because you document the statitics you do in a reproducible way.

Only if you are really desperate (and if you work outside the Heitlinger group, where R is mandatory) go ahead and... 

# Install Prism 5 under macOS

1.  Get the *.iso* file from the HU-smb-share.
2.  Mount the *.iso* file (double click) and then mount the *.dmg* file inside of it.
3.  Double click the Prism-installer (.pkg) and click through the installer.
4.  When the installer sucessfully finished start the program: `Terminal` with the help of the Spotlight (search). Type: `su your_admin_name` (replace *your_admin_name* with your actual name of an administrator account. For example: `su laura`. If you are not sure how your name is spelled, copy this into the `Terminal` and hit enter: `dscl . list /Users | grep -v '^_'`). Then hit enter and enter your password. You will not see yourself typing. Hit Enter.
5.  Now enter into the Terminal: `sudo su`, hit enter and type your password again.
6.  If everything went fine you should see a `#` at the beginning of the Terminal-input. If not just close the `Terminal` repeat the process.
7.  Now enter: `/Applications/Prism\ 5/Prism.app/Contents/MacOS/Prism` (The path to the Prism binary-file) and hit enter.
8.  Prism will now start in *admin-mode*, enter the serial-number which you find inside of the mounted *.iso* (not *.dmg*). Enter a name and instituation with at least 5 characters (it doesn’t matter what you enter).
9.  Close Prism and start it again.
