****************
Virtual machines
****************

Virtual machines or VMs proive a way to deploy software fast, easy and reliable (such as the geneious server or Microsoft-Office).


Create a VM using QEMU
======================

QEMU is a virtualisation software which enables users to create virtual machines with different parameters.

You need to install QEMU:
::
	sudo aptitude install qemu

and download an .iso file of an operating System. Thats all you need to get you started.

The usual QEMU-command we'll use is :code:`qemu-system-x86_64` (there are a lot of different one for other CPU-architectures).

A typical command to start a Windows-vm looks like that:
::
	qemu-system-x86_64 -nodefconfig -machine accel=kvm -enable-kvm -m 2048M -k de -cpu host -smp cores=1,threads=1,sockets=1 -vga qxl -vnc :0 -hda /data/VMs/jessie.qcow2 -net nic,model=e1000 -net user,hostfwd=tcp::27001-:27001,hostfwd=tcp::3306-:3306,hostfwd=tcp::$vms_ssh_port-:22,hostfwd=tcp::49630-:49630 -spice port=15300,addr=$server_IP


-nodefconfig												No default configuration
-machine accel=kvm 											Sets the virtualization technology to KVM
-enable-kvm													Enables the kvm acceleration
-m 2048M													Amount of RAM you want to allocate to the VM
-k de 														Keyboard layout
-cpu host 													Pass the host-CPU identifier to the VM
-smp														Enable smp (multicore support)
-cores=1													Number of CPU cores (try to not exceed )
-vga qxl													protocol to passthrough the graphics (use std for setup)
-vnc :0														VNC Port -> 5900
-spice port=15310,addr=141.20.60.82,password=8aWDxZMqDb		Port for the Spice protocol (to get completely native feeling in a vm), IP address of the host, and spice-password to connect.
-hda														Path to virtual harddisk
-net nic,model=e1000										Model of networkadapter. Usual e1000 for intel and virtio for fullspeed.
-net user,hostfwd											Forwarding ports from host to guest pe.: hostfwd=tcp::15000-:22 the ssh port of the vm is now reacheable through the port 15000 (:code:`ssh user@IP -p 15000`)


Create a new Debian-stable VM
--------------------------------------

Connect to Beagle (or a different machine which should host the vm) and download the Debian-iso `from this site<https://www.debian.org/CD/http-ftp/>`_. Right click the link for the amd64 netinstall and copy the link. Then enter :code:`wget`. paste the link and hit enter. This will download the install-image into the current working directory (:code:`pwd`).

To create a virtual disk for the new vm type:
::
	qemu-img create -f qcow2 /home/marius/debian_testing.qcow2 50G

To start the vm simply type the command:
::
	qemu-system-x86_64 -nodefconfig -machine accel=kvm -enable-kvm -m 4000M  -k de -cpu host -smp cores=4 -vga std -vnc :1 -hda /home/marius/debian_testing.qcow2 -cdrom /home/marius/debian-8.6.0-amd64-netinst.iso -net nic,model=virtio -net user,hostfwd=tcp::15351-:22

connect with a vnc client for example xtightvncviewer. Open xtightvncviewer via terminal and enter the IP of the host and the VNC-port (:code:`141.20.60.126:5901`).

Then just follow this video how to setup the operating system.


Create a new Windows VM
-----------------------

Download the legal and free Windows 10 .iso from `this website <https://www.microsoft.com/de-de/software-download/windows10ISO>`_. This link only works on non Windows machines.

Create a new virtual disk for the Windows-vm:
::
	qemu-img create -f qcow2 Windows10_testing.qcow2 50G

Start the vm with the following command:
::
	qemu-system-x86_64 -nodefconfig -machine accel=kvm -enable-kvm -m 4000M  -k de -cpu host -smp cores=4 -vga std -vnc :1 -hda /home/marius/Windows10_testing.qcow2 -cdrom /home/marius/Win10_1607_EnglishInternational_x64.iso -net nic,model=e1000 -net user -usbdevice tablet

Connect to the vm with a VNC-client. Then install the `spice-guest-tools <https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-latest.exe>`_ on the Windows vm.

After that you have to forward a spice port to the vm.


Connect to a Windows VM using spice-client
==========================================

.. Important::
	The `spice-client <https://packages.debian.org/jessie/spice-client/>`_ available in the Debian repos, provides a way to connect to a virtual machine running Windows with a graphical interface. This allows the user to use Software like the Microsoft Office Suite. The software spice-gues-tools needs to be installed on windows first. To do so connect via VNC the first time you start the VM. Then install `these tools <https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-0.100.exe>`_.

Then you can install the spice-client on any debian machine using:
::
	aptitude install spice-client

You invoke the spice-client with the command :code:`spicec`, additionally you have to provide an IP, a port and the password to connect to the vm.
::
	spicec -h $server_IP -p $port -w $password

A window will pop up you can control it with the following hot-keys.

-shift + F12	Release the catched mouse
-shift + F11	Toggel Fullscreen

Connect to a Linux VM using ssh
===============================

When starting the Linux vm with qemu you have to add a ssh-port forwarding rule with the parameter: :code:`net user,hostfwd`. For example you add: :code:`hostfwd=tcp::15000-:22` then you can connect to the vm with: :code:`ssh user@IP -p 15000` See INSERT LINK for details.


Connect to a Linux VM using a VNC-client (GUI)
==============================================

Install a vnc client on your local machine for example xtightvncviewer (:code:`aptitude install xtightvncviewer`).


