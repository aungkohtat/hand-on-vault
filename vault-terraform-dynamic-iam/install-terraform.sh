#!/bin/bash

# Update package list and install dependencies
sudo apt-get update -y
sudo apt-get install -y curl gnupg software-properties-common

# Add the HashiCorp GPG key
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add the HashiCorp Linux repository
sudo apt-add-repository "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# Update to add the repository and install Terraform
sudo apt-get update -y
sudo apt-get install -y terraform

# Verify the installation
terraform -v

echo "Terraform CLI installation is complete."
