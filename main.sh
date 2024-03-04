#!/bin/bash

# Source configuration
source configs/config.sh;

# Define global variable to store the selected script
selected_script="";

# Function to display script options
display_script_options() {
    echo -e "\n";
    echo -e "${CYAN}Please select a script to run:${NC}";
    echo -e "1. Vulnerability checker (npm-update-packages)";
    echo -e "2. Custom command ${GREEN}(default)${NC}";
}

# Prompt the user to select a script to run
prompt_script_selection() {
    display_script_options;
    read -p "Enter the script number: " script_number;
    case $script_number in
        1)
            echo -e "${GREEN}Running vulnerability checker (npm-update-packages)${NC}";
            selected_script="vulnerability_checker";        
            # Source the script
            source "scripts/common/$selected_script.sh";
        ;;   
        2)
            echo -e "\n${CYAN}ex. 'rm -rf node_modules | rm -f package-lock.json | npm i${NC}'";
            read -p "Enter your custom prompt:" custom_prompt;
            selected_script="${custom_prompt}";        
        ;;               
        *)
            echo -e "\n${CYAN}ex. 'rm -rf node_modules | rm -f package-lock.json | npm i${NC}'";
            read -p "Enter your custom prompt:" custom_prompt;
            selected_script="${custom_prompt}";   
        ;;
    esac
}

# Prompt for script selection
prompt_script_selection;

# Process --all flag
[ $# -eq 0 ] || [ "$*" == *"--all"* ] && {
    REPOSITORIES=$(jq -r '.repositories | keys | .[]' "$REPOSITORIES_CONFIG_FILE");

    for repo_name in $REPOSITORIES; do
        repo_path=$(get_repo_path "$repo_name");
        # Check if the repository directory exists and if so, check vulnerabilities
        check_repo_directory "$repo_path" && {
            # Change directory and run function
            change_repo_directory "$selected_script" "$repo_path";
        }
    done;
    exit 0;
};

# Process command-line arguments
for arg in "$@"; do
    [ "${arg:0:2}" = "--" ] && {
        repo_name="${arg:2}";  # Extract the repository name from the argument
        repo_path=$(get_repo_path "$repo_name");
        [ $? -ne 0 ] && { # It dind't find any key in repository
          echo "$repo_path";
          continue;
        }
        # Check if the repository directory exists and if so, check vulnerabilities
        check_repo_directory "$repo_path" && {
            # Change directory and run function
            change_repo_directory "$selected_script" "$repo_path";

        }

        continue;
    };

    echo -e "${RED}Invalid argument: $arg${NC}";
    exit 1;
done;