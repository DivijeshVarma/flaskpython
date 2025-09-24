#!/bin/bash

# A simple script for a clean Python deployment on a Linux VM.

# Set the target directory for the application
APP_DIR="/home/divijesh/python"
REPO_URL="https://github.com/DivijeshVarma/flaskpython.git"

echo "Beginning deployment..."

# Stop the existing application instance
sudo pkill -9 python3

# Remove the old application directory and its contents
echo "Removing old application directory contents..."
sudo rm -rf "$APP_DIR"
git clone "$REPO_URL" "$APP_DIR"

# Navigate into the application directory
cd "$APP_DIR"

# Install Node.js dependencies
echo "Installing Node.js dependencies..."
python3 -m venv venv

# deploy app
. venv/bin/activate

python3 -m pip install -r requirements.txt

nohup python3 main.py > app.log 2>&1 &

echo "Deployment complete."
