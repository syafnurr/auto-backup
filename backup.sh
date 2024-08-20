#!/bin/bash

# Set variables
BACKUP_DIR="/opt/backup/backup"
REPO_DIR="/opt/backup/auto-backup"
SOURCE_DIR="/compro/develop"
DATE=$(date +"%Y%m%d%H%M")

# Create a backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Find and copy only new or modified files to backup directory
find $SOURCE_DIR -type f -mtime -1 -exec cp --parents {} $BACKUP_DIR \;

# Check if there are any new or modified files to commit
if [ "$(ls -A $BACKUP_DIR)" ]; then
    # Copy backup to GitHub repo
    cp -r $BACKUP_DIR/* $REPO_DIR

    # Navigate to repo directory
    cd $REPO_DIR

    # Git operations
    git add .
    git commit -m "Backup on $DATE"
    git push origin main # or your branch name
else
    echo "No new or modified files to backup."
fi
