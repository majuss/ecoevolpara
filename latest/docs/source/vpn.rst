.. _vpn:
===
VPN
===

VPN means virtual private network. It is a software which will make the computer think you're inside of a different network. This will describe how to setup the VPN connection for the HU-network with an HU-account (required).

Here is the official manual from the `HU-website: <https://www.cms.hu-berlin.de/de/dl/netze/vpn>`_.


-----
macOS
-----

`This is the official manual from the HU for macOS <https://www.cms.hu-berlin.de/de/dl/netze/vpn/openvpn/macosx/ovpn-macosx.pdf>`_

Or you can follow these steps:

1. Go to the `Tunnelblick-website <https://tunnelblick.net/>`_ download the .dmg and drag the .app into your applictions directory.
2. `Download <https://www.cms.hu-berlin.de/de/dl/netze/vpn/openvpn/hu-berlin.ovpn>`_ the HU-VPN configuration file and double click it.
3. Follow the Tunnelblick instructions and enter your account details. A small smybol will show up in the status bar. 


-----
Linux
-----

`This is the official manual from the HU for Linux <https://www.cms.hu-berlin.de/de/dl/netze/vpn/openvpn/allgemein/ovpn-linux.pdf>`_

Or you can follow these steps:

1. Install open VPN on your system with: :code:`sudo aptitude install openvpn` (actual command depends on Linux distribution).
2. `Download <https://www.cms.hu-berlin.de/de/dl/netze/vpn/openvpn/hu-berlin.ovpn>`_ the HU-VPN configuration file.
3. Run :code:`sudo openvpn --config hu-berlin.ovpn

-------
Windows
-------

`This is the official manual from the HU for Linux <https://www.cms.hu-berlin.de/de/dl/netze/vpn/openvpn/windows10/ovpn-win10.pdf>`_

Or you can follow these steps:

1. `Download openVPN <https://www.cms.hu-berlin.de/de/dl/netze/vpn/openvpn/openvpn-install-x86_64-cms.exe>`_ and install it.
2. Open the installed openVPN with right click and choose "with administrator privileges".
3. Type in the credentials for your HU-account.