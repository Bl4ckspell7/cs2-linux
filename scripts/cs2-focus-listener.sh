#!/bin/bash

# Specify the process name and the scripts you want to execute
PROCESS_NAME="cs2"            # e.g. "firefox"
FOCUS_GAIN_SCRIPT="./focus_cs2.sh"       # Script to execute on focus gain
FOCUS_LOSS_SCRIPT="./unfocus_cs2.sh"       # Script to execute on focus loss

# Function to get the process ID of the current window's owner
get_pid_from_window_id() {
    WINDOW_ID=$(xprop -root _NET_ACTIVE_WINDOW | awk '{print $5}')
    if [ "$WINDOW_ID" = "0x0" ]; then
        # No active window
        echo ""
        return
    fi
    PID=$(xprop -id "$WINDOW_ID" _NET_WM_PID | awk '{print $3}')
    echo "$PID"
}

# Variable to keep track of the currently focused process PID
previous_focused_process=""

# Main event loop to monitor focus changes
xprop -root -spy _NET_ACTIVE_WINDOW | while read -r _ ; do
    # Get the currently focused window's process ID
    focused_pid=$(get_pid_from_window_id)

    if [ -n "$focused_pid" ]; then
        # Check if the currently focused window belongs to the target process
        if pgrep -x "$PROCESS_NAME" | grep -q "^$focused_pid$"; then
            if [ "$previous_focused_process" != "$PROCESS_NAME" ]; then
                # Execute focus gain script if switching to the target process
                echo "Process $PROCESS_NAME gained focus, executing script: $FOCUS_GAIN_SCRIPT"
                bash "$FOCUS_GAIN_SCRIPT"
            fi
            # Update the previous focused process
            previous_focused_process="$PROCESS_NAME"
        else
            if [ "$previous_focused_process" = "$PROCESS_NAME" ]; then
                # Execute focus loss script if leaving the target process
                echo "Process $PROCESS_NAME lost focus, executing script: $FOCUS_LOSS_SCRIPT"
                bash "$FOCUS_LOSS_SCRIPT"
            fi
            # Update the previous focused process
            previous_focused_process=""
        fi
    else
        # Handle case where there is no valid window ID
        if [ "$previous_focused_process" = "$PROCESS_NAME" ]; then
            echo "Process $PROCESS_NAME lost focus, executing script: $FOCUS_LOSS_SCRIPT"
            bash "$FOCUS_LOSS_SCRIPT"
        fi
        previous_focused_process=""
    fi
done


