#!/bin/bash

router_id=$(hostname | rev | cut -d '-' -f 1 | rev)

ip addr add 1.1.1.$router_id/32 dev lo

if [[ $router_id == '2' ]]; then
    ip addr add 10.1.1.2/30 dev eth0
elif [[ $router_id == '3' ]]; then
    ip addr add 10.1.1.6/30 dev eth0
elif [[ $router_id == '4' ]]; then
    ip addr add 10.1.1.10/30 dev eth0
fi


ip link add name vxlan10 type vxlan id 10 dstport 4789
brctl addbr br0
brctl addif br0 eth1
brctl addif br0 vxlan10
ip link set dev br0 up
ip link set dev vxlan10 up

vtysh <<EOF
    configure terminal
        interface eth0
        ip ospf area 0
        interface lo
        ip ospf area 0
        router bgp 1
        neighbor 1.1.1.1 remote-as 1
        neighbor 1.1.1.1 update-source lo
        address-family l2vpn evpn
        neighbor 1.1.1.1 activate
        advertise-all-vni
        exit-address-family
        router ospf
    end
EOF
