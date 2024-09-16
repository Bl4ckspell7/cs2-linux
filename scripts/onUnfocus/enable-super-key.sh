#!/bin/bash

# Define the keycode for the Super key
SUPER_KEYCODE=133

# Temporary file to store the original Super key mapping
TEMP_FILE="/tmp/xmodmap_superkey_mapping"

# Function to check if the Super key is already enabled
is_super_key_enabled() {
    CURRENT_MAPPING=$(xmodmap -pke | grep "keycode $SUPER_KEYCODE =")
    if [[ $CURRENT_MAPPING != "keycode $SUPER_KEYCODE =" ]]; then
        return 0 # Super key is enabled
    else
        return 1 # Super key is disabled
    fi
}

# Function to enable the Super key by restoring its original mapping
enable_super_key() {
    if [[ -f $TEMP_FILE ]]; then
        ORIGINAL_MAPPING=$(cat "$TEMP_FILE")
        echo "Restoring Super key to: $ORIGINAL_MAPPING"
        xmodmap -e "$ORIGINAL_MAPPING"
    else
        echo "No backup found, unable to restore Super key."
    fi
}

# Main enable function
main() {
    if is_super_key_enabled; then
        echo "Super key is already enabled."
    else
        enable_super_key
    fi
}

# Execute the main function
main

