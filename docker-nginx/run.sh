#!/bin/bash

# Define the docker-compose file path
COMPOSE_FILE="docker-compose.yml"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Check if the docker-compose file exists
if [ ! -f "$COMPOSE_FILE" ]; then
  echo -e "${RED}Configuration file $COMPOSE_FILE does not exist.${NC}"
  exit 1
fi

# Check command argument
if [ $# -ne 1 ]; then
  echo -e "${RED}Usage: $0 {start|delete}${NC}"
  exit 1
fi

COMMAND=$1

case "$COMMAND" in
  start)
    echo -e "${GREEN}Starting all services defined in $COMPOSE_FILE...${NC}"
    docker compose up -d
    EXIT_STATUS=$?
    if [ $EXIT_STATUS -ne 0 ]; then
      echo -e "${RED}Failed to start services (Exit Status: $EXIT_STATUS)${NC}"
      exit $EXIT_STATUS
    fi
    echo -e "${BLUE}All services started successfully.${NC}"
    ;;
    
  delete)
    echo -e "${GREEN}Stopping and removing all services defined in $COMPOSE_FILE...${NC}"
    docker compose down
    EXIT_STATUS=$?
    if [ $EXIT_STATUS -ne 0 ]; then
      echo -e "${RED}Failed to delete services (Exit Status: $EXIT_STATUS)${NC}"
      exit $EXIT_STATUS
    fi
    echo -e "${BLUE}All services removed successfully.${NC}"
    ;;
    
  *)
    echo -e "${RED}Invalid command: $COMMAND. Use 'start' or 'delete'.${NC}"
    exit 1
    ;;
esac

# Output completion message in blue
echo -e "${BLUE}Command '$COMMAND' completed.${NC}"