Hardware
========

Setting up a new client computer
--------------------------------

You should use debian testing for new machines due to it’s better compatibily with modern hardware.

Get a working Linux client and [downlaod the Debian testing iso]. Then transfer the image via the `dd` command to the USB-stick. Determine the disk number of the USB-stick via the `lsblk`.

::  
dd if=/home/username/downloads/debian.iso of=/dev/disk2

When `dd` is finished unplug the USB-drive and stick it into the new computer. Depending on the vendor you have to press a different F-key while booting the new machine (usually F12 or F2). Then you should get into the boot-menu from the computer and choose the USB-stick.

The Debian-installer should show up now. Choose the non-graphical installer.

And follow this video how to setup the operating system correctly.

Svalbard
--------

Svalbards chassis-manual can be found here &lt;appendix/pdfs/ChassisSC836.pdf&gt;. It is crucial to have a look at it, if you want to install new harddrives.

-   Intel Xeon E5-2623 v3
-   Supermicro X10SRL-F retail
-   Supermicro SuperChassis CSE-836TQ-R500B Black
-   Noctua NH-D9DX i4 3U
-   4x Kingston ValueRAM DIMM 4 GB DDR4-2133 Registered - KVR21R15S8/4
-   2x 250 GB Samsung EVO 850 V1
-   6x Western Digital WD Red Pro 6 TB - WD6001FFWX

Harriet (Dell PowerEdge R820)
-----------------------------

-   4x Intel Xeon E5-4617
-   2,5" Chassis with up to 16 Hard Drives
-   32x 16 GB RDIMM, 1600 MHz, Low Volt, Dual Rank, x4
-   2x 146 GB SAS 6Gbit/s 15k 2,5Zoll Festplatte Hot Plug
-   4x 1,2 TB SAS 6Gbit/s 10k 2,5Zoll Festplatte Hot-Plug
-   QLogic QLE2562, Dual Port 8Gb Optical Fibre Channel HBA, Low Profile
-   Broadcom 5720 QP 1Gb Network Daughter Card
-   LSI Logic LSI00301 Host Bus Adapter (removed original Dell PERC H710p)
-   iDRAC7 Enterprise

Beagle
------

-   2x Xeon E5450
-   8x 4 GB buffered DDR 2 PC-667
-   Chieftec Mesh schwarz LCX-01B-B-SL-OP
-   PCIe 4N GF8400GS 256MB MSI
-   Supermicro X7DAE
-   3x 2 TB 3,5"

Monitoring and maintaining the hardware
---------------------------------------

First of all you should take a look onto the monthly maintenance reports from our bots in Slack. They will post a hardware-log and a short message if everything seems right or wrong.

### How to interpret the log from the Slack bot

The logfile contains 2 crucial types of information:

-   the SMART status of all mass storage devices (INSERT LINKS TO SMART INTERPRETATION)
-   the result of the btrfs scrubbing (INSERT LINK TO BTRFS)

All you have to know about the SMART-status is, that it gives you a general overview of the disks health. How many hours is it spinning, how oftern turned it of and on, how recoverable errors is it producing. As long as the “SMART Health Status” is said to be “OK” you don’t have to worry about it. If an harddisk does not pass the SMART test all the work on the affe

  [downlaod the Debian testing iso]: http://cdimage.debian.org/cdimage/weekly-builds/amd64/iso-cd/