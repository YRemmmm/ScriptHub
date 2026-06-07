#!/bin/bash

if [ -f "scripts/.env" ]; then
  source scripts/.env
fi

SERVICE="$1"

create_container() {
    local target="$1"
    for service in "${SERVICES[@]}"; do
        if [[ "$service" == "$target" ]]; then
            echo "Processing service: $service"
            cd $service && sudo docker compose up -d && cd ..
            return 0
        fi
    done
    
    echo "Service not found: $target"
    return 1
}

create_all_containers() {
    for service in "${SERVICES[@]}"; do
        echo "Processing service: $service"
        cd $service && sudo docker compose up -d && cd .. 2>/dev/null || echo "Failed to process service: $service"
    done
}

if [[ "$SERVICE" == "all" ]]; then
    # Check if network exists
    if docker network inspect shared-net >/dev/null 2>&1; then
        echo "Network shared-net already exists, skipping creation"
    else
        echo "Creating network shared-net..."
        docker network create shared-net
        echo "Network created successfully"
    fi
    create_all_containers
else
    create_container "$SERVICE"
fi