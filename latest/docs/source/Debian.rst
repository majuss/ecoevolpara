******
Debian
******

Debian is a common and completely free Linux distribution. It is released in 3 release-branches. Stable, stretch and experimental. We are using the stretch release, since debian-stable is very conservtive and updates getting rolled out pretty slow.


===============================
Administrator / Root privileges
===============================

Normal users don't have the privileges to install software and change system configurations like adding printers. The so called :code:`root` user is the administrator. You can change to that user with :code:`su root` if you know the password. Otherwise we use the program :code:`sudo` to provide normal users admin privs without using the user root directly. The privileged users are entered in :code:`visudo` with a line like that :code:`victor ALL=(ALL:ALL) ALL`.

Victor then have the privs to call a program as administrator (root) with the :code:`sudo command`.

================
Install software
================

First look if you can find the software you are looking for in the official debian repositories with:
::
    aptitude search $softwarename

This will list all findings, if nothing get's posted your software is not inside the official repos. Then you have to evaluate if you really need this software... When you really need it google for a download link. You should go for a package with the ending ".deb" which indicates a debian package. Often these packages are listed under Ubuntu, since Ubuntu is a Debian-derivate.



If the search finds your desired software you can easily install it via:
::
    aptitude install $softwarename



=========================
Update and upgrade Debian
=========================

Test
::
    aptitude update

Will update the package list/cache. Always run this before you upgrading or installing software!
::
    aptitude upgrade

Will upgrade all packages which are outdated.

------------------------------------------
Software that needs regular manual updates
------------------------------------------
- seafile server
- rstudio server
- 


=====================
Working with printers
=====================



sudo system-config-printer

=============================
Add programs to the autostart
=============================


.. figure:: appendix/pictures/startup1.jpg
   :width: 450px
   :alt: How to autostart a program