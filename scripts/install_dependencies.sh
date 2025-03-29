#!/bin/bash
set -e  # Exit on error

echo "Installing dependencies..."

# Update packages
sudo yum update -y

# Install Docker if not already installed
if ! command -v docker &> /dev/null; then
    echo "Installing Docker..."
    sudo yum install -y docker
    sudo systemctl start docker
    sudo systemctl enable docker
else
    echo "Docker is already installed."
fi

# Install Docker Compose if not installed
if ! command -v docker-compose &> /dev/null; then
    echo "Installing Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.6/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
else
    echo "Docker Compose is already installed."
fi

# Install CodeDeploy agent (if not installed)
if ! sudo service codedeploy-agent status; then
    echo "Installing CodeDeploy agent..."
    sudo yum install -y ruby wget
    cd /tmp
    wget https://aws-codedeploy-ca-central-1.s3.ca-central-1.amazonaws.com/latest/install
    chmod +x ./install
    sudo ./install auto
    sudo service codedeploy-agent start
else
    echo "CodeDeploy agent is already running."
fi

# Ensure Docker is running
sudo systemctl start docker
sudo systemctl enable docker

echo "Dependencies installed successfully!"
