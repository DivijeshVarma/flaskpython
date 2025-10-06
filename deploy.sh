#!/bin/bash

# A simple script for a clean Python deployment on a Linux VM.

# Set the target directory for the application
APP_DIR="/home/divijesh/python"
REPO_URL="https://github.com/DivijeshVarma/flaskpython.git"

echo "Beginning deployment..."

# --- Step 1: Pre-Deployment Cleanup and Setup ---

# 🛑 CRITICAL FIX: Run apt update before any install
echo "Updating package lists..."
sudo apt update -y

# 🛑 CRITICAL FIX: Use the standard 'python3-venv' package name
echo "Installing python3-venv..."
sudo apt install -y python3-venv

# Stop the existing application instance
echo "Stopping existing Python processes..."
sudo pkill -9 python3 2>/dev/null || true # Suppress error if no process is running

# --- Step 2: Code Checkout ---

# Remove the old application directory and its contents
echo "Removing old application directory contents..."
sudo rm -rf "$APP_DIR"

# Create the new directory and clone the repository
echo "Cloning repository into $APP_DIR..."
sudo mkdir -p "$APP_DIR"
git clone "$REPO_URL" "$APP_DIR"

# Navigate into the application directory
cd "$APP_DIR"

# --- Step 3: Environment Setup and Run ---

echo "Creating and setting up virtual environment..."

# Create the virtual environment
sudo python3 -m venv venv

# 💡 FIX: Set the path to the Python executable directly inside the venv
VENV_PYTHON="./venv/bin/python3"
VENV_PIP="./venv/bin/pip"

# Install dependencies using the venv's pip
echo "Installing dependencies..."
sudo $VENV_PIP install -r requirements.txt

# Start the application using the venv's python and nohup
echo "Starting application with nohup..."
# The nohup command should use the full path to the python executable
# Running this command with '&' ensures the script finishes, but the process continues.
nohup $VENV_PYTHON main.py > app.log 2>&1 &

echo "Deployment complete."
