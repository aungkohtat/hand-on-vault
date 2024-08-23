#!/bin/bash

# Update package list and install dependencies
sudo apt-get update -y
sudo apt-get install -y unzip curl

# Download AWS CLI version 2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip the package
unzip awscliv2.zip

# Install the AWS CLI
sudo ./aws/install

# Verify the installation
aws --version

# Clean up
rm -rf awscliv2.zip aws/

echo "AWS CLI installation is complete."
