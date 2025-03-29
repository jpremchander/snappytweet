#!/bin/bash
set -e  # Exit on error

echo "Stopping existing Docker containers..."

# Stop all running containers
if [ "$(sudo docker ps -q)" ]; then
    sudo docker stop $(sudo docker ps -q)
    echo "All running containers stopped."
else
    echo "No running containers found."
fi
