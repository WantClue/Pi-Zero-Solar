#!/bin/bash

# This script shall overview of what you want to do.

GREEN='\033[0;32m'
RED='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

check_curl() {
  if ! command -v curl >/dev/null 2>&1; then
    echo "curl is not installed, installing..."
    sudo apt-get update
    sudo apt-get install -y curl
  else
    echo "curl is already installed"
  fi
}


# Display menu
echo -e "${CYAN}Please choose an option:${NC}"
echo -e "${YELLOW}1. Install LCD driver${NC}"
echo -e "${YELLOW}2. Create Python script${NC}"
echo -e "${YELLOW}3. Exit${NC}"

# Get user input
read -p "Enter option number: " choice

# Process user input
case "$choice" in
  1)
    echo -e "${GREEN}Installing LCD driver...${NC}"
    # Call function to install LCD driver
    check_curl
    curl -sSL https://raw.githubusercontent.com/WantClue/Pi-Solar/main/install-LCD.sh | bash
    ;;
  2)
    echo -e "${GREEN}Creating Python script...${NC}"
    # Call function to create Python script
    ;;
  3)
    echo -e "${GREEN}Exiting...${NC}"
    exit 0
    ;;
  *)
    echo -e "${RED}Invalid choice, please try again.${NC}"
    ;;
esac