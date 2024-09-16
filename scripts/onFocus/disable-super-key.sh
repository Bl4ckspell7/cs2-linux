#!/bin/bash

# Define the keycode for the Super key
SUPER_KEYCODE=133

# Temporary file to store the original Super key mapping
TEMP_FILE="/tmp/xmodmap_superkey_mapping"

# Function to disable the Super key
disable_super_key() {
    echo "Disabling Super key..."
    xmodmap -e "keycode $SUPER_KEYCODE ="
}

# Function to check if the Super key is already disabled
is_super_key_disabled() {
    CURRENT_MAPPING=$(xmodmap -pke | grep "keycode $SUPER_KEYCODE =")
    if [[ $CURRENT_MAPPING == "keycode $SUPER_KEYCODE =" ]]; then
        return 0 # Super key is disabled
    else
        return 1 # Super key is not disabled
    fi
}

# Main disable function
main() {
    if ! is_super_key_disabled; then
        # If Super key is enabled, save its original mapping and disable it
        ORIGINAL_MAPPING=$(xmodmap -pke | grep "keycode $SUPER_KEYCODE =")
        echo "Saving current Super key mapping: $ORIGINAL_MAPPING"
        echo "$ORIGINAL_MAPPING" > "$TEMP_FILE"
        disable_super_key
    else
        echo "Super key is already disabled."
    fi
}

# Execute the main function
main
