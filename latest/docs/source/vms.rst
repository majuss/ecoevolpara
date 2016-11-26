****************
Virtual machines
****************

Virtual machines or VMs proive a way to deploy software fast and easy (such as the geneious server). 


======================
Create a VM using QEMU
======================

QEMU is...

You need to install QEMU:
::
	aptitude install qemu

Download an .iso file of an operating System. 




The usual QEMU-command we'll use is :code:`qemu-system-x86_64`.

==========================================
Connect to a Windows VM using spice-client
==========================================

The `spice-client <https://packages.debian.org/jessie/spice-client/> available in the Debian repos, provides a way to connect to a virtual machine running Windows with a graphical interface. This allows the user to use Software like the Microsoft Office Suite.

First you need to install the spice-client:
::
	aptitude install spice-client

You invoke the spice-client with the command :code:`spicec`, additionally you have to provide an IP, a port and the password to connect to the vm.
::
	spicec spicec -h $server_IP -p $$port -w $password

===============================
Connect to a Linux VM using ssh
===============================

==============================================
Connect to a Linux VM using a VNC-client (GUI)
==============================================

