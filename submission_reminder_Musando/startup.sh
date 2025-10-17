#!/bin/bash

# Get the absolute directory of this script
base_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Locate the reminder app
reminder_file="$base_path/scripts/reminder.sh"

# Verify config file exists before running
if [ ! -f "$base_path/config/config.env" ]; then
    echo " Missing config.env file. Please ensure it's available in $base_path/config"
    exit 1
fi

# Run the main reminder program
bash "$reminder_file"

