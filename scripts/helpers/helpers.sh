#!/bin/bash

# ANSI color codes for text colors
source assets/colors.sh;

# Function to get repository path
get_repo_path() {
    local repo_name="$1";
    local repo_path=$(jq -r ".repositories.$repo_name" "$REPOSITORIES_CONFIG_FILE");

    [ "$repo_path" != "null" ] || { echo -e "${RED}Repository key '$repo_name' not found in '$MAIN_CONFIG_FILE'${NC}"; exit 1; };

    echo "$ABSOLUTE_ROOT_PATH/$repo_path";
}

# Function to check if the repository directory exists
check_repo_directory() {    
    local repo_path="$1";
    [ -d "$repo_path" ] || { echo -e "${RED}Repository $repo_path not found${NC}"; exit 1; }
}

# Function to change the repository directory and to go back to project-iterator directory
change_repo_directory() {    
    # Define selected_script as a local variable
    local selected_script="$1";
    # Define repo_path as a local variable
    local repo_path="$2";
    
    echo -e "${CYAN}Checking vulnerabilities for $repo_path repository...${NC}";

    # Store the current directory on the stack
    pushd . > /dev/null;
    # Change directory to the repository
    cd "$repo_path" || exit 1;

    # Run the specified script
    "$selected_script"; 

    # Return to the previous directory
    popd > /dev/null;

    echo "======================================================================="
}
