********
Hardware
********



========
Svalbard
========

Svalbards chassis-manual can be found :download:`here <appendix/pdfs/ChassisSC836.pdf>`


=======================
Monitoring the hardware
=======================

Look at maintenance reports in Slack.

-----------------
CPU and RAM usage
-----------------

htop

-------------------
Harddisks / Storage
-------------------

smartctl

------------
Temperatures
------------

To monitor the temperature it is best and fastest to use the programm sensors. You install it via "aptitude install sensors". Then you hvae to detect all thermal sensors installed into the system.

sensors detect all - no input



=======================================================
Remotely connect via iDRAC (Harriet) and IPMI (Svalbard)
=======================================================

-----
iDrac
-----

With the integrated Dell Remote Access Controller you can manage the server remotely. It's basically a tiny computer inside of the server. 

The recent IP to connect to harriets DRAC you can find in the IP-routing table. You have to enter the IP into a browser and then you will be prompted with an username and password. Both can be found in the groups keepass-database. With the help of the DRAC and a java console you are able to mount .iso files into the system and install new operating systems.


