#!/bin/bash

if [ -f "scripts/.env" ]; then
  source scripts/.env
fi

SERVICE="$1"

delete_container() {
    local target="$1"
    for service in "${SERVICES[@]}"; do
        if [[ "$service" == "$target" ]]; then
            echo "Processing service: $service"
            sudo docker stop $service && sudo docker rm $service
            return 0
        fi
    done
    
    echo "Service not found: $target"
    return 1
}

delete_all_containers() {
    for service in "${SERVICES[@]}"; do
        echo "Processing service: $service"
        sudo docker stop $service 2>/dev/null && sudo docker rm $service 2>/dev/null || echo "Failed to process service: $service"
    done
}

if [[ "$SERVICE" == "all" ]]; then
    delete_all_containers
else
    delete_container "$SERVICE"
fi