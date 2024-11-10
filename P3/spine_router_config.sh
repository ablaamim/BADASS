#!/bin/bash

ip addr add 10.1.1.1/30 dev eth0
ip addr add 10.1.1.5/30 dev eth1
ip addr add 10.1.1.9/30 dev eth2
ip addr add 1.1.1.1/32 dev lo

vtysh <<EOF
    configure terminal
        router bgp 1
        neighbor ibgp peer-group
        neighbor ibgp remote-as 1
        neighbor ibgp update-source lo
        bgp listen range 1.1.1.0/24 peer-group ibgp
        address-family l2vpn evpn
        neighbor ibgp activate
        neighbor ibgp route-reflector-client
        exit-address-family
        router ospf
        network 0.0.0.0/0 area 0
    end
EOF

