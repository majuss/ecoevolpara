********
Geneious
********

A lot of members of the institute are using a software called “geneious” to analyse DNA-data. We have 6 licenses which are only compatible with the version 6.1.8 (you can get this old version `here <http://www.geneious.com/previous-versions/>`_). The server providing the licenses is Beagle. Additionally to the license server, Beagle is running a mysql server, which provides the “shared database” for all geneious-users at the institute.


===========================================
Set up the Geneious License Server (Beagle)
===========================================

This Tutorial will guide you from the start to set up the geneious license server on a completely new machine. It requires you in the first place to create a virtual machine with Debian stable. Stable because in the later releases, software which is required by the geneious license server was removed from Debian. So you need an Debian running a 3.X Kernel or earlier.

Inside of the Debian stable VM you need to download the `server software <http://www.geneious.com/installers/licensingUtility/2_0_3/GeneiousLicenseServer_linux64_2_0_3_with_jre.sh/>`_. Then start the script with root priveleages. During the installing process you will be asked for the license key. It is located in our KeePassX-database. All other option can be left at default. The license-server is now installed in /path/to/ 




===============================
Setup the mysql database-server
===============================

https://support.rackspace.com/how-to/installing-mysql-server-on-ubuntu/


============================
Setting up a Geneious client
============================

Wuff.

============================
Log into the shared Database
============================

To smth.