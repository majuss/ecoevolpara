Virtual machines
================

Virtual machines or VMs proive a way to deploy software fast, easy and reliable (such as the geneious server or Microsoft-Office).

Create a VM using QEMU
----------------------

QEMU is a virtualisation software which enables users to create virtual machines with different parameters.

You need to install QEMU: :: sudo aptitude install qemu

and download an .iso file of an operating System. Thats all you need to get you started.

The usual QEMU-command we’ll use is `qemu-system-x86_64` (there are a lot of different one for other CPU-architectures).

A typical command to start a Windows-vm looks like that: :: qemu-system-x86\_64 -nodefconfig -machine accel=kvm -enable-kvm -m 2048M -k de -cpu host -smp cores=1,threads=1,sockets=1 -vga qxl -vnc :0 -hda /data/VMs/jessie.qcow2 -net nic,model=e1000 -net user,hostfwd=tcp::27001-:27001,hostfwd=tcp::3306-:3306,hostfwd=tcp::$vms\_ssh\_port-:22,hostfwd=tcp::49630-:49630 -spice port=15300,addr=$server\_IP

-nodefconfig No default configuration -machine accel=kvm Sets the virtualization technology to KVM -enable-kvm Enables the kvm acceleration -m 2048M Amount of RAM you want to allocate to the VM -k de Keyboard layout -cpu host Pass the host-CPU identifier to the VM -smp Enable smp (multicore support) -cores=1 Number of CPU cores (try to not exceed ) -vga qxl protocol to passthrough the graphics (use std for setup) -vnc :0 VNC Port -&gt; 5900 -spice port=15310,addr=141.20.60.82,password=8aWDxZMqDb Port for the Spice protocol (to get completely native feeling in a vm), IP address of the host, and spice-password to connect. -hda Path to virtual harddisk -net nic,model=e1000 Model of networkadapter. Usual e1000 for intel and virtio for fullspeed. -net user,hostfwd Forwarding ports from host to guest pe.: hostfwd=tcp::15000-:22 the ssh port of the vm is now reacheable through the port 15000 (`ssh user@IP -p 15000`)

### Create a new Debian-stable VM

Connect to Beagle (or a different machine which should host the vm) and download the Debian-iso [from this site]. Right click the link for the amd64 netinstall and copy the link. Then enter `wget`. paste the link and hit enter. This will download the install-image into the current working directory (`pwd`).

To create a virtual disk for the new vm type: :: qemu-img create -f qcow2 /home/marius/debian\_testing.qcow2 50G

To start the vm simply type the command: :: qemu-system-x86\_64 -nodefconfig -machine accel=kvm -enable-kvm -m 4000M -k de -cpu host -smp cores=4 -vga std -vnc :1 -hda /home/marius/debian\_testing.qcow2 -cdrom /home/marius/debian-8.6.0-amd64-netinst.iso -net nic,model=virtio -net user,hostfwd=tcp::15351-:22

connect with a vnc client for example xtight

  [from this site]: https://www.debian.org/CD/http-ftp/