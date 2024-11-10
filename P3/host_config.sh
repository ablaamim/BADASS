#!/bin/bash


host_id=$(hostname | rev | cut -d '-' -f 1 | rev)

ip addr add 192.168.1.$host_id/24 dev eth0
