#!/bin/bash

for cont_id in $(docker ps -q); do
    current_hostname=$(docker exec $cont_id hostname)
    if [[ "$current_hostname" =~ ^host_.*-[12]$ ]]; then
        echo "copy host_config to $current_hostname"
        docker cp ./host_config.sh $cont_id:/
        docker exec $cont_id bash /host_config.sh
    elif [[ "$current_hostname" =~ ^routeur_.*-[12]$ ]]; then
        echo "copy router_config to $current_hostname"
            
    fi
done

