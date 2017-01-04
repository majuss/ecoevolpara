********
Hardware
********



========
Svalbard
========

Svalbards chassis-manual can be found :download:`here <appendix/pdfs/ChassisSC836.pdf>`. It is crucial to have a look at it, if you want to install new harddrives.

=======================
Monitoring the hardware
=======================

First of all you should take a look onto the maintenance reports from our bots in Slack. They will post a hardware-log and a short message if everything seems right or wrong.

-----------------
CPU and RAM usage
-----------------

Install and run the utility htop: :code:`aptitude install htop`.

-------------------
Harddisks / Storage
-------------------

smartctl

------------
Temperatures
------------

To monitor the temperature it is best and fastest to use the programm sensors. You install it via "aptitude install sensors". Then you hvae to detect all thermal sensors installed into the system.

:code:`sensors detect --auto`

For the temperatures of the harddrives you need to use :code:`smartctl -x "/dev/sd$f"` with admin privileges.

=======================================================
Remotely connect via iDRAC (Harriet) and IPMI (Svalbard)
=======================================================

-----
iDrac
-----

With the integrated Dell Remote Access Controller you can manage the server remotely. It's basically a tiny computer inside of the server. 

The recent IP to connect to harriets DRAC you can find in the IP-routing table. You have to enter the IP into a browser and then you will be prompted with an username and password. Both can be found in the groups keepass-database. With the help of the DRAC and a java console you are able to mount .iso files into the system and install new operating systems.

To use the java-console, you need to start a specific preconfigured vm and connect to it, or you install java on your local computer and add a security-exception for the DRACs IP (https://141...).


