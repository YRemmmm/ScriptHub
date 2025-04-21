#!/bin/bash

# Define the directory containing .sh files and the .env file path
SCRIPT_DIR="src"
ENV_FILE=".env"

# Check if the .env file exists
if [ ! -f "$ENV_FILE" ]; then
  echo "Configuration file $ENV_FILE does not exist."
  exit 1
fi

# Read each line from the .env file as a script filename into an array
mapfile -t SCRIPTS < "$ENV_FILE"

# Iterate over the list of scripts in the .env file
for SCRIPT_NAME in "${SCRIPTS[@]}"; do
  # Construct the full path to the script
  SCRIPT_PATH="$SCRIPT_DIR/$SCRIPT_NAME"
  
  # Determine if the file exists and output its status
  if [ -f "$SCRIPT_PATH" ]; then
    echo -e "\033[0;32m$SCRIPT_PATH exists\033[0m"
  else
    echo -e "\033[0;31m$SCRIPT_PATH does not exist\033[0m"
    continue # Skip non-existent scripts
  fi
  
  # Execute the script
  echo -e "\033[0;32mExecuting: $SCRIPT_PATH\033[0m"
  bash "$SCRIPT_PATH" # Or directly execute with "./$SCRIPT_PATH" if it has execution permission and correct shebang
  EXIT_STATUS=$? # Capture the exit status of the last command
  
  if [ $EXIT_STATUS -ne 0 ]; then
    # Output error message in red if the script fails
    echo -e "\033[0;31mExecution failed: $SCRIPT_PATH (Exit Status: $EXIT_STATUS)\033[0m"
    exit $EXIT_STATUS # Stop the entire process on failure
  fi
done

# Output completion message in blue when all scripts have been executed
echo -e "\033[0;34mAll scripts have been executed in order specified by .env\033[0m"