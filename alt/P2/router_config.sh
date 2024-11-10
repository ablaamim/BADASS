#!/bin/bash

if [[ $1 == '' ]]; then
	echo "Must provide 'static' or 'multi' as argument."
	exit 0
fi

router_id=$(hostname | rev | cut -d '-' -f 1 | rev)
echo $router_id
ip addr add 10.1.1.$router_id/24 dev eth0

if [[ $1 == 'multi' ]]; then
	ip link add name vxlan10 type vxlan id 10 dev eth0 \
		group 239.1.1.1 dstport 4789
else
	ip link add name vxlan10 type vxlan id 10 dev eth0 \
		local 10.1.1.$router_id remote 10.1.1.$((3-$router_id)) dstport 4789
fi


brctl addbr br0
ip link set dev br0 up
brctl addif br0 eth1
brctl addif br0 vxlan10
ip link set dev vxlan10 up

