#!/usr/bin/bash

# Prompt user for their name to personalize the environment
read -p "Enter your name: " username

# Define the main project directory
main_dir="submission_reminder_${username}"
mkdir -p "$main_dir"

# Create subdirectories for different components of the application
mkdir -p "$main_dir/scripts"
mkdir -p "$main_dir/helpers"
mkdir -p "$main_dir/resources"
mkdir -p "$main_dir/config"

# Define directory shortcuts for easy reference
scripts_dir="$main_dir/scripts"
helpers_dir="$main_dir/helpers"
resources_dir="$main_dir/resources"
config_dir="$main_dir/config"

# ------------------- CONFIG FILE -------------------
cat > "$config_dir/config.env" << 'EOF'
# Configuration file for the submission reminder app
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# ------------------- REMINDER SCRIPT -------------------
cat > "$scripts_dir/reminder.sh" << 'EOF'
#!/bin/bash

# Load configuration and utility functions
source ./config/config.env
source ./helpers/functions.sh

# Path to the list of student submissions
submissions_file="$(dirname "$0")/../resources/submissions.txt"

# Display assignment info and invoke reminder logic
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF

# ------------------- FUNCTIONS SCRIPT -------------------
cat > "$helpers_dir/functions.sh" << 'EOF'
#!/bin/bash

# Function to identify students with pending submissions
function check_submissions {
    local file=$1
    echo "Analyzing submission records in $file"

    # Read each record (ignoring the header)
    while IFS=, read -r student assignment status; do
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Print reminder for those who haven’t submitted
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo " Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$file")
}
EOF

# ------------------- SUBMISSIONS FILE -------------------
cat > "$resources_dir/submissions.txt" << 'EOF'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Mwiti, Git, submitted
Musando, Git, not submitted
Yvonne, Shell Navigation, not submitted
Antoinne, Shell Basics, submitted
Stephen, Shell Navigation, not submitted
Michael, Git, not submitted
Richard, Shell Basics, submitted
EOF

# ------------------- STARTUP SCRIPT -------------------
cat > "$main_dir/startup.sh" << 'EOF'
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

EOF

# ------------------- PERMISSIONS SETUP -------------------
chmod +x $scripts_dir/*
chmod +x $helpers_dir/*
cd $main_dir
chmod +x startup.sh
cd ..

echo "Environment setup complete!"
echo "To launch the app, run:"
echo "cd $main_dir && ./startup.sh"

