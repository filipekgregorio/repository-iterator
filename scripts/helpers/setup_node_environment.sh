#!/bin/bash

# ANSI color codes for text colors
source assets/colors.sh;

# Path to the NVM executable
NVM_EXECUTABLE="$HOME/.nvm/nvm.sh";

# Source NVM script if it exists, otherwise display an error message and exit
nvm_init() {
  [ -f "$NVM_EXECUTABLE" ] || {
    echo -e "${RED}NVM script not found. Please make sure NVM is installed in this directory '$NVM_EXECUTABLE'.${NC}";
    exit 1;
  };

  source "$NVM_EXECUTABLE" || {
      echo -e "${RED}Failed to source NVM script.${NC}";
      exit 1;
  };
}

# Install and use a specified version of Node.js
install_and_use_node() {
    local VERSION="${1:---lts}";
    
    echo -e "${CYAN}Installing Node.js version $VERSION...${NC}";
    nvm install "$VERSION" --reinstall-packages-from=current || {
        echo -e "${RED}Failed to install Node.js version $VERSION.${NC}";
        exit 1;
    };

    # Use the installed Node.js version
    # echo -e "${CYAN}Using Node.js version $VERSION...${NC}";
    # nvm use "$VERSION" || {
    #     echo -e "${RED}Failed to use Node.js version $VERSION.${NC}";
    #     exit 1;
    # };
}

# Initialize NVM
nvm_init;

# Install and use Node.js
# TODO right now always run node LTS version, but we can pass also the version as parameter
# install_and_use_node "$@"
install_and_use_node "--lts";