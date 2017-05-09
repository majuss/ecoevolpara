# Virtual machines

Virtual machines or VMs proive a way to deploy software fast, easy and reliable (such as the geneious server or Microsoft-Office).

## Create a VM using QEMU

QEMU is a virtualisation software which enables users to create virtual machines with different parameters.

You need to install QEMU: `sudo aptitude install qemu`.

and download an .iso file of an operating System. Thats all you need to get you started.

The usual QEMU-command we’ll use is `qemu-system-x86_64` (there are a lot of different one for other CPU-architectures).

A typical command to start a Windows-vm looks like that: :: qemu-system-x86\_64 -nodefconfig -machine accel=kvm -enable-kvm -m 2048M -k de -cpu host -smp cores=1,threads=1,sockets=1 -vga qxl -vnc :0 -hda /data/VMs/jessie.qcow2 -net nic,model=e1000 -net user,hostfwd=tcp::27001-:27001,hostfwd=tcp::3306-:3306,hostfwd=tcp::$vms\_ssh\_port-:22,hostfwd=tcp::49630-:49630 -spice port=15300,addr=$server\_IP

-nodefconfig No default configuration -machine accel=kvm Sets the virtualization technology to KVM -enable-kvm Enables the kvm acceleration -m 2048M Amount of RAM you want to allocate to the VM -k de Keyboard layout -cpu host Pass the host-CPU identifier to the VM -smp Enable smp (multicore support) -cores=1 Number of CPU cores (try to not exceed ) -vga qxl protocol to passthrough the graphics (use std for setup) -vnc :0 VNC Port -&gt; 5900 -spice port=15310,addr=141.20.60.82,password=8aWDxZMqDb Port for the Spice protocol (to get completely native feeling in a vm), IP address of the host, and spice-password to connect. -hda Path to virtual harddisk -net nic,model=e1000 Model of networkadapter. Usual e1000 for intel and virtio for fullspeed. -net user,hostfwd Forwarding ports from host to guest pe.: hostfwd=tcp::15000-:22 the ssh port of the vm is now reacheable through the port 15000 (`ssh user@IP -p 15000`)

### Create a new Debian-stable VM

Connect to Beagle (or a different machine which should host the vm) and download the Debian-iso [from this site]. Right click the link for the amd64 netinstall and copy the link. Then enter `wget`. paste the link and hit enter. This will download the install-image into the current working directory (`pwd`).

To create a virtual disk for the new vm type: :: qemu-img create -f qcow2 /home/marius/debian\_testing.qcow2 50G

To start the vm simply type the command: :: qemu-system-x86\_64 -nodefconfig -machine accel=kvm -enable-kvm -m 4000M -k de -cpu host -smp cores=4 -vga std -vnc :1 -hda /home/marius/debian\_testing.qcow2 -cdrom /home/marius/debian-8.6.0-amd64-netinst.iso -net nic,model=virtio -net user,hostfwd=tcp::15351-:22

connect with a vnc client for example xtightvncviewer. Open xtightvncviewer via terminal and enter the IP of the host and the VNC-port (`141.20.60.126:5901`).

Then just follow this video how to setup the operating system.

## Create a new Windows VM

Download the legal and free Windows 10 .iso from [this website]. This link only works on **non Windows** machines.

Create a new virtual disk for the Windows-vm: :: qemu-img create -f qcow2 Windows10\_testing.qcow2 50G

Start the vm with the following command: :: qemu-system-x86\_64 -nodefconfig -machine accel=kvm -enable-kvm -m 4000M -k de -cpu host -smp cores=4 -vga std -vnc :1 -hda /home/marius/Windows10\_testing.qcow2 -cdrom /home/marius/Win10\_1607\_EnglishInternational\_x64.iso -net nic,model=e1000 -net user -usbdevice tablet

Connect to the vm with a VNC-client. Then install the [spice-guest-tools] on the Windows vm.

After that you have to forward a spice port to the vm.

### Connect to a Windows VM using spice-client on Debian

The [spice-client] available in the Debian repos, provides a way to connect to a virtual machine running Windows with a graphical interface. This allows the user to use Software like the Microsoft Office Suite. The software spice-gues-tools needs to be installed on windows first. To do so connect via VNC the first time you start the VM. Then install [these tools].

Then you can install the spice-client on any debian machine using: :: aptitude install spice-client

You invoke the spice-client with the command `spicec`, additionally you have to provide an IP, a port and the password to connect to the vm. :: spicec -h $server\_IP -p $port -w $password

A window will pop up you can control it with the following hot-keys.

-shift + F12 Release the catched mouse -shift + F11 Toggel Fullscreen

### Connect to a Linux VM using ssh

When starting the Linux vm with qemu you have to add a ssh-port forwarding rule with the parameter: `net user,hostfwd`. For example you add: `hostfwd=tcp::15000-:22` then you can connect to the vm with: `ssh user@IP -p 15000` See INSERT LINK for details.

### Connect to a Linux VM using a VNC-client (GUI)


Install a vnc client on your local machine for example xtightvncviewer (`aptitude install xtightvncviewer`).

  [this website]: https://www.microsoft.com/de-de/software-download/windows10ISO
  [spice-guest-tools]: https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-latest.exe
  [spice-client]: https://packages.debian.org/jessie/spice-client/
  [these tools]: https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-0.100.exe
  [from this site]: https://www.debian.org/CD/http-ftp/