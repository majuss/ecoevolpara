*********************************
Filesystem and harddiskmanagement
*********************************


btrfs
=====

Btrfs is with ZFS the only filesystem that can detect and prevent silent-data-corruption when paired with ECC-RAM. Additionally you can create software-RAIDs very easily without any controller. We don’t use RAID 5 since restoring data is a pain. Also the prices for huge harddisks are now very low. Btrfs will only work satisfyingly with Kernel 4.4 and above. Thats why we are using Debian stretch/sid. The command:
::
    btrfs fi show


will show all set up btrfs-filesystems and the free space on them. Every fs will handled with an UUID.
::
    btrfs scrub start /mountpoint


Will scrub the targeted fs. This means the fs will check all block-checksums and correct errors automatically. When started once it will run til finished. Scrubbing will take a lot of time (100 mb/s). You should scrub the fs once every month. The status of the recent scrub can be checked with:
::
    btrfs scrub status /mountpoint


To create a complete new RAID or add a harddisk to an existing one you first have to format the drive with a GPT:
::
    parted -s /dev/sdz mklabel gpt mkpart primary 1% 100%


This command will use parted to create a GPT on sdz (you can read out the drive-letters with lsblk). You should restart the server after this step, because the new disk will likely not be detected correctly. After the restart you add the device to an existing RAID with:
::
    btrfs device add /dev/sdz1 /


Here sdz1 getting added to the RAID /. You can create a complete new RAID 1 from multiple devices with:
::
    mkfs.btrfs -d raid1 -m raid1 /dev/sdc1 /dev/sdd1 /dev/sde1 /dev/sdf1


After adding devices to RAIDs you always have to balance the data between them.
::
    btrfs balance start -mconvert=raid1 -dconvert=raid1 /


Mounting the SAN storage
========================

The SAN - storage area network - is a network storage attached over 8 Gbit fibre channel. Currently we have 15 TB of storage mounted on harriet at /SAN.

Follow :download:`this manual <appendix/pdfs/Multipathing-Ubuntu-1404.pdf>` to mount the external storage.

Additional to the manual see `this error <http://pissedoffadmins.com/os/mount-unknown-filesystem-type-lvm2_member.html/>`_ which will occur.*

Scan logical volumes
::
    lvscan
load device module
::
    modprobe dm-mod
change the volumes that exist to active
::
    vgchange -ay
mount the logical partition
::
    mkdir -p /mnt/VolGroup00/LogVol00
    mount /dev/VolGroup00/LogVol00 /mnt/VolGroup00/LogVol00


