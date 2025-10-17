#!/bin/bash

# Get absolute path of this script
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Path to reminder.sh
reminder_script="$script_dir/app/reminder.sh"

# Check if config file exists
if [ ! -f "$script_dir/config/config.env" ]; then
    echo "Error: config.env not found. Please run this script from inside $script_dir"
    exit 1
fi

# Launch the reminder app
bash "$reminder_script"

