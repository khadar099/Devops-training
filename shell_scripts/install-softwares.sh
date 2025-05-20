#!/bin/bash

set -e

echo "Updating system..."
sudo apt update -y && sudo apt upgrade -y

echo "Installing Java 17..."
sudo apt install -y openjdk-17-jdk

echo "Installing Maven..."
sudo apt install -y maven

echo "Installing Node.js & NPM..."
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

echo "Installing Docker..."
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Adding current user to docker group..."
sudo usermod -aG docker $USER

echo "Installing Jenkins..."
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | \
  sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | \
  sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y
sudo apt install -y jenkins

echo "Starting and enabling Jenkins service..."
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "Installation complete!"
echo "Reboot or log out and back in to apply Docker group changes."
