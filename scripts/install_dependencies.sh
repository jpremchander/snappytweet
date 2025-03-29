#!/bin/bash
# Install Docker and Docker Compose
sudo yum update -y

# Install Docker (if not already installed)
if ! command -v docker &> /dev/null; then
    sudo yum install docker -y
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -aG docker ec2-user
fi

# Install AWS CLI (if not already installed)
if ! command -v aws &> /dev/null; then
    sudo yum install aws-cli -y
fi

# Authenticate Docker with AWS - ECR
aws ecr get-login-password --region ca-central-1 | docker login --username AWS --password-stdin 054037100649.dkr.ecr.ca-central-1.amazonaws.com
