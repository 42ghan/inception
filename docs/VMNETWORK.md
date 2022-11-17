# Virtual Machine Network (VirtualBox)

- This section explains how virtual machines, specifically the machines that are run by VirtualBox, communicate with each other and outside world via network.

## NAT with Port Forwarding
- NAT is a default network mode for VirtualBox VMs.
- The Oracle VM VirtualBox networking engine acts as a router between VMs and the host. It is positioned between each VM and the host, and maps traffic from and to a VM transparently.
- VMs cannot talk to each other.
- VM -> outside - the TCP/IP data of the network frames sent out by a VM is replaced by the data of the host OS. - Other applications in and out of the host machine, sees the traffic as if it has been originated from the VirtualBox application.
- outside -> VM - once the VirtualBox receives a reply, it repacks and resends it to the guest machine on its private network.
- In order to allow the host machine or machines over the net to talk to VMs, port forwarding must be set, such that VirtualBox may listen to certain ports on the host, and resend the packets that arrive there to the guest's port.

## Network Address Translation Service
- NAT Service acts as a home router allowing VMs to talk with each other (via the internal network) and the outside (not directly but with help of port forwarding) by using TCP and UDP over IPv4 and IPv6.

## Bridged Networking
- The VirtualBox uses a device driver on the host system to filter data from the physical network adaptorand inject data into it. It effectively creates a new network interface in software.
- When a guest uses the interface, the host system sees it as if the guest were physically connected to the interface by a cable. VMs can send data to the host and receive data form the host.

## Internal Networking
- The same as [the bridged networking](#bridged-networking), but it allows only communication between VMs. Since there is no physical adaptor attached, packets cannot be intercepted, thus it has security advantages over bridged network.
- It ensures private communication between VMs.

## Host-only Networking
- A hybrid between the bridged and internal networking modes. There is no physical adaptor.
- The VirtualBox creates a new software loopback interface by which VMs can communicate with the host, but not with the outside.
- The VMs can still communicate with each other privately over the internal network.

## References
- [VirtualBox networking modes](https://www.virtualbox.org/manual/ch06.html#networkingmodes)
