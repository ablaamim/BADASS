#!/bin/bash

for cont_id in $(docker ps -q); do
    current_hostname=$(docker exec $cont_id hostname)
    echo $current_hostname
    if [[ "$current_hostname" =~ ^host_.*-[123]$ ]]; then
        echo "copy host_config to $current_hostname"
        docker cp ./host_config.sh $cont_id:/
        docker exec $cont_id bash /host_config.sh
    elif [[ "$current_hostname" =~ ^routeur_.*-[234]$ ]]; then
        echo "copy router_config [leaf] to $current_hostname"
        docker cp ./leaf_router_config.sh $cont_id:/
        docker exec $cont_id bash /leaf_router_config.sh
    elif [[ "$current_hostname" =~ ^routeur_.*-[1]$ ]]; then
        echo "copy router_config [spine] to $current_hostname"
        docker cp ./spine_router_config.sh $cont_id:/
        docker exec $cont_id bash /spine_router_config.sh
    fi
done

