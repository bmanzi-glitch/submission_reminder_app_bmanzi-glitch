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
