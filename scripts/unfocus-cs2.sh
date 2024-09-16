#!/bin/bash

# Define the list of scripts you want to run
SCRIPTS_TO_RUN=(
    "./onUnfocus/enable-super-key.sh"
     "./onUnfocus/16-9.sh"
)

# Iterate over each script in the list
for SCRIPT_TO_RUN in "${SCRIPTS_TO_RUN[@]}"; do
    if [[ -x "$SCRIPT_TO_RUN" ]]; then
        # Run the script
        echo "Running $SCRIPT_TO_RUN..."
        "$SCRIPT_TO_RUN"
    else
        echo "Error: $SCRIPT_TO_RUN does not exist or is not executable."
        exit 1
    fi
done
