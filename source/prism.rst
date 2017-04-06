Install Prism 5 under macOS
===========================


1. Get the .iso file from the HU-smb-share.
2. Mount the .iso file (double click) and then mount the .dmg file inside of it.
3. Double click the Prism-installer (.mpkg) and click through the installer.
4. When the installer sucessfully finished start the program: :code:`Terminal` with the spotlight. Type: :code:`su youradminname` (replace youradminname with your actual name of an administrator account. For example: :code:`su laura`). Then hit enter and enter your password. You will not see yourself typing. Hit Enter.
5. Now enter into the Terminal: :code:`sudo su`, hit enter and type ypur password again.
6. If everything went fine you should see a :code:`#` at the beginning of the Terminal-input.
7. Now enter: :code:`/Applications/Prism\ 5/Prism.app/Contents/MacOS/Prism` (The path to the Prism binary-file) and hit enter.
8. Prism will now start in "admin-mode", enter the serial-number which you find inside of the mounted .iso (not .dmg). Enter A name and instituation with at least 5 characters (it doesn't matter what you enter).
9. Close Prism and start it again.