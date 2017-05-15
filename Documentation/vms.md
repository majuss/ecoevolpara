# Virtual machines

Virtual machines or VMs proive a way to deploy software fast, easy and reliable (such as the geneious server or Microsoft-Office).

## Create a VM using QEMU

QEMU is a virtualisation software which enables users to create virtual machines with different parameters.

You need to install QEMU: `sudo aptitude install qemu`.

and download an .iso file of an operating System. Thats all you need to get you started.

The usual QEMU-command we’ll use is `qemu-system-x86_64` (there are a lot of different one for other CPU-architectures).

A typical command to start a Windows-vm looks like that:
```
qemu-system-x86\_64 -nodefconfig -machine accel=kvm -enable-kvm -m 2048M -k de -cpu host -smp cores=1,threads=1,sockets=1 -vga qxl -vnc :0 -hda /data/VMs/jessie.qcow2 -net nic,model=e1000 -net user,hostfwd=tcp::27001-:27001,hostfwd=tcp::3306-:3306,hostfwd=tcp::$vms\_ssh\_port-:22,hostfwd=tcp::49630-:49630 -spice port=15300,addr=$server\_IP
```

Command | Meaning
--------|-------
`nodefconfig` | No default configuration
`machine accel=kvm` | Sets the virtualization technology to KVM
`enable-kvm` | Enables the kvm acceleration
`m 2048M`| Amount of RAM you want to allocate to the VM
`k de` | Keyboard layout
`cpu host` | Passes the host-CPU identifier to the VM
`smp` | Enables smp (multicore processing)
`cores=1` | Number of CPU cores to allocate (never exceed the hosts physical core count)
`vga qxl` | Graphics passthrough protocol (use `std` for setup)
`vnc :0` | VNC port -> 5900
<ul><li>`spice port=15310,`</li><li>`addr=141.20.60.82,`</li><li>`password=abcedf`</li></ul>| <ul><li>Port for the Spice protocol (to get completely native feeling in a vm)</li><li>IP address of the host</li><li>and spice-password to connect</li></ul>
`hda /home/horst/debian.qcow2` | Path to virtual disk
`net nic,model=e1000` | Model of virtualized networkadapter, usual e1000 for intel and `virtio` for fullspeed
`net user,hostfwd` | Forwarding ports from host to guest pe.: `hostfwd=tcp::15000-:22` the ssh port of the vm is now reacheable through the port 15000 (`ssh user@IP -p 15000`)

### Create a new Debian-stable VM

Connect to Beagle (or a different machine which should host the vm) and download the Debian-iso [from this site]. Right click the link for the amd64 netinstall and copy the link. Then enter `wget`. paste the link and hit enter. This will download the install-image into the current working directory (`pwd`).

To create a virtual disk for the new vm type:
```
qemu-img create -f qcow2 /home/marius/debian_testing.qcow2 50G
```
To start the vm simply type the command:
```
qemu-system-x86_64 -nodefconfig -machine accel=kvm -enable-kvm -m 4000M -k de -cpu host -smp cores=4 -vga std -vnc :1 -hda /home/marius/debian_testing.qcow2 -cdrom /home/marius/debian-8.6.0-amd64-netinst.iso -net nic,model=virtio -net user,hostfwd=tcp::15351-:22
```

Connect with a VNC client for example xtightvncviewer. Open xtightvncviewer via terminal and enter the IP of the host and the VNC-port (`141.20.60.126:5901`).

Then just follow this video how to setup the operating system.

INSERT VIDEO

## Create a new Windows VM

Download the legal and free Windows 10 .iso from [this website]. You have to enter some credentials then the download will start. You have to download the enterprise edition, because only this version will get activated by the HUs key management server.

Create a new virtual disk for the Windows-VM:
```
qemu-img create -f qcow2 Windows10_testing.qcow2 50G
```
Start the vm with the following command:
```
qemu-system-x86_64 -nodefconfig -machine accel=kvm -enable-kvm -m 4000M -k de -cpu host -smp cores=4 -vga std -vnc :1 -hda /home/marius/Windows10_testing.qcow2 -cdrom Path/To/Windows.iso -net nic,model=e1000 -net user -usbdevice tablet
```
Connect to the VM with a VNC-client. Then install the [spice-guest-tools] on the Windows VM.

After that you have to forward a spice port to the VM.

### Connect to a Windows VM using spice-client on Debian

The [spice-client] available in the Debian repos, provides a way to connect to a virtual machine running Windows with a graphical interface. This allows the user to use Software like the Microsoft Office Suite. The software spice-gues-tools needs to be installed on Windows first. To do so connect via VNC the first time you start the VM. Then install [these tools].

Then you can install the spice-client on any debian machine using:
```
sudo aptitude install spice-client
```
You invoke the spice-client with the command `spicec`, additionally you have to provide an IP, a port and the password to connect to the VM. `spicec -h $server_IP -p $port -w $password`

A window will pop up you can control it with the following hot-keys.

Key combination | Effect
----------------|-------
shift + F12 | Releases the catched mouse cursor
shift + F11 | Toggle Fullscreen


### Connect to a Linux VM using ssh

When starting the Linux vm with qemu you have to add a ssh-port forwarding rule with the parameter: `net user,hostfwd`. For example you add: `hostfwd=tcp::15000-:22` then you can connect to the vm with: `ssh user@IP -p 15000` See INSERT LINK for details.

### Connect to a Linux VM using a VNC-client (GUI)


Install a vnc client on your local machine for example xtightvncviewer (`aptitude install xtightvncviewer`).

  [this website]: https://www.microsoft.com/de-de/evalcenter/evaluate-windows-10-enterprise
  [spice-guest-tools]: https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-latest.exe
  [spice-client]: https://packages.debian.org/jessie/spice-client/
  [these tools]: https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-0.100.exe
  [from this site]: https://www.debian.org/CD/http-ftp/