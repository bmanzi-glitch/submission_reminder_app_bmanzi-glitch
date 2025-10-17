#!/usr/bin/bash

# Define key directory and file references
main_dir="submission_remainder_*/"
launcher="startup.sh"
env_file="./submission_remainder_*/config/config.env"

# Control variables
repeat_process="y"
selected_assignment=""  # Stores user input for the assignment name

# ------------------ FUNCTION TO HANDLE REMINDERS ------------------
launch_reminder() {
    # The selected assignment is passed as the first argument
    chosen_assignment="$1"

    if [ ! -d $main_dir ]; then
        sleep 0.9
        echo " Directory missing. Please execute create_environment.sh first."
        echo ""
        exit 1
    else
        # Update assignment name inside config.env
        sed -i "s/ASSIGNMENT=\".*\"/ASSIGNMENT=\"$selected_assignment\"/" $env_file
        echo " Updating configuration to check: '$chosen_assignment'"

        # Move into the reminder folder and run startup.sh
        cd $main_dir
        if [ ! -f $launcher ]; then
            echo " Error: $launcher not found inside directory."
            exit 1
        else
            ./$launcher
            cd ..
        fi
    fi
}

# ------------------ MAIN USER INTERACTION LOOP ------------------
while [[ "$repeat_process" == "y" || "$repeat_process" == "Y" ]]; do
    echo ""
    echo " Which assignment would you like to check?"
    echo "Example options:
- Shell Navigation
- Shell Basics
- Git"

    read -p "Enter the assignment name: " selected_assignment

    # Call the reminder function
    launch_reminder "$selected_assignment"

    echo ""
    read -p "Would you like to analyze another assignment? (y/n): " repeat_process
done

echo -e " Exiting the reminder system..."


