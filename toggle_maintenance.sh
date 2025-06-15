#!/bin/bash

# Check if argument is provided
if [ -z "$1" ]; then
  echo "Usage: ./toggle_maintenance.sh [on|off]"
  exit 1
fi

# Enable maintenance mode
if [ "$1" == "on" ]; then
  # Check if _site directory exists
  if [ ! -d "_site" ]; then
    echo "Error: _site directory not found."
    exit 1
  fi

  # Check if maintenance.html exists
  if [ ! -f "maintenance.html" ]; then
    echo "Error: maintenance.html not found."
    exit 1
  fi

  # Check if _site_backup directory already exists
  if [ -d "_site_backup" ]; then
    echo "Error: _site_backup directory already exists. Please remove it first."
    exit 1
  fi

  # Create backup of _site directory
  mv _site _site_backup
  echo "Backup of _site directory created as _site_backup."

  # Remove all contents of _site directory
  mkdir _site

  # Copy maintenance.html into _site as index.html
  cp maintenance.html _site/index.html

  echo "Maintenance mode enabled."
  exit 0
fi

# Disable maintenance mode
if [ "$1" == "off" ]; then
  # Check if _site_backup directory exists
  if [ ! -d "_site_backup" ]; then
    echo "Error: No backup found. Cannot disable maintenance mode."
    exit 1
  fi

  # Remove current _site directory
  rm -rf _site

  # Restore _site directory from _site_backup
  mv _site_backup _site

  echo "Maintenance mode disabled. Site restored."
  exit 0
fi

# Invalid argument
echo "Usage: ./toggle_maintenance.sh [on|off]"
exit 1
