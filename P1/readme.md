 # Part 1 
 
 ## GNS3 configuration with Docker 

---

Requirements :

* VirtualBox as hypervisor

* Ubuntu < 23.04 (The gns3 PPA currently supports only Ubuntu 22.10 and earlier because it hasn't been updated to 23.04 yet)

* GNS3

* Docker engine

* FRrouring image

---

## What is GNS3 and what are its basic functionalities 

> GNS3 (Graphical Network Simulator 3) is a popular tool for network simulation, commonly used in networking projects and labs. It enables the creation of complex network topologies that include virtual routers, switches, firewalls, and other devices. Here's an introduction to its basics, the interest of BGP, and the differences between Layer 2 and Layer 3:

### GNS3 Basics

Purpose: GNS3 lets you design and simulate networks virtually, which is useful for testing configurations, studying network protocols, and learning about network behavior without the need for physical hardware.
Key Functionalities:

* Network Topology Design: Drag and drop virtual devices like routers, switches, and computers to create network layouts.

* Device Emulation: Uses emulators (like Dynamips and QEMU) to run real router and switch software, allowing you to work with nearly identical configurations and protocols as physical devices.

* Real-Time Packet Flow: Simulates the packet flow between devices in real time, making it possible to test complex setups.

* Integration with External Software: Can integrate with other tools like Wireshark for packet capture, or with virtual machines for end-to-end network simulations.

* Layered Simulation: Supports both Layer 2 and Layer 3 configurations, helping you explore both switching and routing.

## Border Gateway Protocol (BGP)

BGP is a Layer 3 protocol essential for managing how packets are routed across the internet. It is commonly used by ISPs and data centers for inter-domain routing. Here’s why BGP is important:

* Scalability: BGP can handle the massive routing tables required to route data across the internet.

* Policy-Based Routing: Allows network administrators to control the path taken by data based on policy rules, which is crucial for optimizing network performance and security.

* Fault Tolerance: BGP can reroute traffic in case of link failures, providing robustness in large networks.

* Autonomous System (AS) Communication: BGP allows communication between different autonomous systems, making it possible for data to travel across various networks globally.

## Layer 2 vs. Layer 3

Understanding these two layers is key to networking:

* Layer 2 (Data Link Layer):
Operates on MAC addresses and is responsible for local data transfers within the same network segment (e.g., within the same LAN).
Switches are typical Layer 2 devices, working within the local network without crossing boundaries.
Common protocols: Ethernet, ARP, VLANs.

* Layer 3 (Network Layer):
Operates on IP addresses and is responsible for routing packets between different networks.
Routers are Layer 3 devices, determining paths for packets to reach different networks and allowing internet connectivity.
Common protocols: IP, ICMP, and routing protocols like OSPF and BGP.

> In GNS3, you'll be able to simulate both Layer 2 and Layer 3 functionalities by using switches and routers in your topologies, helping you understand both local and global network communication patterns. This will be especially useful as you work with BGP, which relies heavily on Layer 3 routing concepts.

---

# GNS3 Installation 

```bash
sudo apt update
sudo apt upgrade
sudo add-apt-repository ppa:gns3/ppa
sudo apt update                                
sudo apt install gns3-gui gns3-server
sudo apt install docker.io
sudo apt install docker-compose
```

---

# Images setup

## First Image: Host Node

* Base Image : Alpine Linux (lightweight, minimal system).
Core Tool: Busybox for essential command-line tools.

* Configuration :
Basic System: Only requires a minimal Unix environment with Busybox to interact with the system.

* Service:
Busybox Shell : Provides essential tools for basic commands and network debugging (e.g., ping, ifconfig).

* Use Case :
Acts as a simple network host or endpoint for testing connectivity, running lightweight commands, and serving as a node in a network topology.
Useful for verifying routing configurations, performing network diagnostics, and testing network reachability.

## Second Image: Router Node

* Base Image : Linux-based image (e.g., Debian or Alpine) with FRRouting (FRR) software or Quagga/Zebra for routing.

* Configuration :
Routing Software Configuration:
Enable BGPD for external routing (simulates ISP-level routing).
Enable OSPF for internal routing (simulates intra-organization routing).
Enable IS-IS for high-scalability internal routing (simulates large ISP networks).

* Services :
BGPD (BGP Daemon): Manages Border Gateway Protocol for external routing.
OSPF Daemon: Handles internal routing within autonomous systems.

* IS-IS Daemon : Provides ISP-grade internal routing, suited for large-scale networks.
Busybox: Adds basic utilities for system interaction, troubleshooting, and network commands.

* Use Case :
Functions as a network router with multiple routing protocols, allowing for complex routing simulations.
Ideal for setting up realistic networking environments where both internal and external routing protocols are needed.
Simulates interactions between internal enterprise networks and external internet-facing networks in GNS3.
