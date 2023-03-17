#!/bin/bash

# This script shall overview of what you want to do.

GREEN='\033[0;32m'
RED='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# checks if curl is been installed
check_curl() {
  if ! command -v curl >/dev/null 2>&1; then
    echo "curl is not installed, installing..."
    sudo apt-get update
    sudo apt-get install -y curl
  else
    echo "curl is already installed"
  fi
}
# checks if influxdb-client is been installed
check_install_influxdb_client() {
    if ! command -v influx; then
        echo "InfluxDB client is not installed. Installing..."
        pip3 install influxdb-client
    else
        echo "InfluxDB client is already installed."
    fi
}
# check if this script is been run as root
check_root() {
  if [[ $EUID -ne 0 ]]; then
     echo "This script must be run as root" 
     exit 1
  fi
}
# checks if figlet is installed and if not it installes it
check_figlet() {
    if ! command -v figlet &> /dev/null
    then
        echo "Figlet is not installed. Installing..."
        sudo apt-get update
        sudo apt-get install -y figlet
    else
        echo "figlet is already installed."
    fi
}

# call the function to check if the script is run as root
check_root

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
    read -p "Press [Enter] key to continue..."
    check_curl
    read -p "Press [Enter] key to continue..."
    check_install_influxdb_client
    read -p "Press [Enter] key to continue..."
    check_figlet
    read -p "Press [Enter] key to continue..."
    #curl -sSL https://raw.githubusercontent.com/WantClue/Pi-Solar/main/install-LCD.sh | bash
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