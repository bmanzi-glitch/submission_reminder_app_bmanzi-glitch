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
