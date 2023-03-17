#!/bin/bash

# This script installs the driver for the Waveshare 3.5 inch RPi LCD (A) for the Pi Zero W
# with SPI interface.

# Update package list
sudo apt-get update

# Clone driver repository
git clone https://github.com/waveshare/LCD-show.git

# Change directory to the cloned repository
cd LCD-show/

# Make the file executable
chmod +x LCD35-show

# Install the driver for the display
sudo ./LCD35-show lite
