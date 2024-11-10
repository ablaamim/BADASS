## VXLAN configuration

---

> VXLAN is a technology that allows networks to extend across different locations by encapsulating network traffic, enabling up to 16 million unique segments. It’s more scalable than VLAN, which supports only 4096 segments, making VXLAN ideal for large, multi-tenant environments.

---

### Step 1: Bridge Setup on Routers

Create a bridge interface (br0) on each router:
Run `ip link add br0 type bridge` to create the bridge, which will allow eth1 and vxlan10 interfaces to communicate at Layer 2.
Set the bridge up with `ip link set dev br0 up`.


### Step 2: Configuring VXLAN in Static Mode
This setup will connect the routers via a virtual network using VXLAN encapsulation over their physical eth0 interfaces.

Router 1:

Assign an IP (10.1.1.1/24) to eth0 using this command :
```bash
ip addr add 10.1.1.1/24 dev eth0

# check 

ip addr show eth0

```

Create the VXLAN interface (vxlan10) with ID 10, setting:
remote to 10.1.1.2 (Router 2’s IP) to establish the tunnel endpoint.
local to 10.1.1.1 (Router 1’s IP) as the local endpoint.
dstport to 4789, the standard port for VXLAN.

```bash
ip link add name vxlan10 type vxlan 10 dev eth0 remote 10.1.1.2 local 10.1.1.1 dstport 4789
```

Assign IP 20.1.1.1/24 to vxlan10 to allow communication between the VXLAN endpoints.
```bash
ip addr add 20.1.1.1/24 dev vxlan10
```


Router 2:

Configure similarly to Router 1 but set eth0 IP as 10.1.1.2/24 and local and remote as Router 2’s and Router 1’s IPs, respectively.
Assign 20.1.1.2/24 to vxlan10.

---

### Step 3: Configuring VXLAN in Multicast Mode (Alternative to Static)

Instead of setting remote endpoints, routers use a multicast group (e.g., 239.1.1.1) to dynamically discover other VXLAN endpoints in the network.
On Router 1 and Router 2:
Assign IPs (10.1.1.1/24 on Router 1, 10.1.1.2/24 on Router 2) to eth0.
Create vxlan10 with multicast configuration:
Specify group as 239.1.1.1, so routers can dynamically discover other routers in the VXLAN.
Use dstport 4789.
Assign respective IPs (20.1.1.1 and 20.1.1.2) to vxlan10.

### Step 4: Adding Interfaces to Bridge

Attach the physical (eth1) and VXLAN (vxlan10) interfaces to the bridge (br0) on each router to integrate them into the same Layer 2 network.
Use brctl addif br0 eth1 and brctl addif br0 vxlan10.
Set vxlan10 up with ip link set dev vxlan10 up.

```bash
brctl addif br0 eth1 
brctl addif br0 vxlan10
ip link set dev vxlan10 up
```

### Step 5: Host Configuration

* Host 1:

Assign IP 30.1.1.1/24 to eth1.
Test connectivity to Host 2 by running ping 30.1.1.2.
```bash
ip addr add 30.1.1.1/24 dev eth1

```

* Host 2:

Assign IP 30.1.1.2/24 to eth1.
Test connectivity to Host 1 by running ping 30.1.1.1.

```bash
ip addr add 30.1.1.2/24 dev eth1


```


Summary
The configuration allows Hosts 1 and 2 to communicate through the routers using VXLAN.
Static VXLAN mode requires setting specific remote addresses for each endpoint, while multicast mode dynamically discovers endpoints.
Adding interfaces to the bridge integrates VXLAN and physical interfaces, enabling communication across the VXLAN.