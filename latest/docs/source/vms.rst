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

A typical command to start a QEMU-vm looks like that:
::
	qemu-system-x86_64 -nodefconfig -machine accel=kvm -enable-kvm -m 2048M  -k de -cpu host -smp cores=1,threads=1,sockets=1 -vga qxl -vnc :0 -hda /data/VMs/jessie.qcow2 -net nic,model=virtio -net user,hostfwd=tcp::27001-:27001,hostfwd=tcp::3306-:3306,hostfwd=tcp::$vms_ssh_port-:22,hostfwd=tcp::49630-:49630 -spice port=15300,addr=$server_IP


qemu-system-x86_64		QEMU command
-nodefconfig			miau
-machine accel=kvm 		nodefconf
-enable-kvm				
-m 2048M				amount of RAM you want to allocate to the VM
-k de 					keyboard layout
-cpu host 				pass the host-CPU identifier to the VM
-smp					enable smp
-cores=1				number of CPU cores
-threads=1				number of logical threads
-sockets=1				number of cpu sockets
-vga qxl				protocol to passthrough the graphics
-vnc :0					VNC Port -> 5900
-hda					Path to harddisk
-net nic,model=virtio	model of networkadapter
-net user,hostfwd		forwarding ports from host to vm pe.: hostfwd=tcp::15000-:22 the ssh port of the vm is now reacheable through the port 15000



==========================================
Connect to a Windows VM using spice-client
==========================================

The `spice-client <https://packages.debian.org/jessie/spice-client/>`_ available in the Debian repos, provides a way to connect to a virtual machine running Windows with a graphical interface. This allows the user to use Software like the Microsoft Office Suite.

First you need to install the spice-client:
::
	aptitude install spice-client

You invoke the spice-client with the command :code:`spicec`, additionally you have to provide an IP, a port and the password to connect to the vm.
::
	spicec spicec -h $server_IP -p $port -w $password

===============================
Connect to a Linux VM using ssh
===============================

==============================================
Connect to a Linux VM using a VNC-client (GUI)
==============================================

