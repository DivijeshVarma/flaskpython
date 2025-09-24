#!/bin/bash

# A simple script to deploy a Node.js application to a Linux VM by cloning a git repository.

# Set the target directory for the application
APP_DIR="/home/divijesh/python"
REPO_URL="https://github.com/DivijeshVarma/flaskpython.git"

echo "Beginning deployment..."

# Stop the existing application instance
sudo pkill -9 python3

# Clone the repository
echo "Cloning the repository from $REPO_URL..."
git clone "$REPO_URL" "$APP_DIR"

# Navigate into the application directory
cd "$APP_DIR"

# Install Node.js dependencies
echo "Installing Node.js dependencies..."
python3 -m venv venv

# deploy app
source venv/bin/activate

python3 -m pip install -r requirements.txt

nohup python3 main.py > app.log 2>&1 &

echo "Deployment complete."
