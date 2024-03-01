#!/bin/bash

# Source setup_node_environment.sh script to set up the Node.js environment
source scripts/helpers/setup_node_environment.sh;

# ANSI color codes for text colors
source assets/colors.sh;

# Check if the configuration file exists
REPOSITORIES_CONFIG_FILE="configs/repositories.json";
[ -f "$REPOSITORIES_CONFIG_FILE" ] || {
    echo -e "${RED}Configuration file '$REPOSITORIES_CONFIG_FILE' not found.${NC}";
    exit 1;
};

# Read the configuration from the JSON file
ABSOLUTE_ROOT_PATH=$(jq -r '.absolute_root_path' "$REPOSITORIES_CONFIG_FILE");

# Source helpers
source scripts/helpers/helpers.sh;