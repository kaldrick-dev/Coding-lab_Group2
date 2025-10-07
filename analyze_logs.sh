#!/bin/bash

while true; do
    echo "Select log file to analyze:"
    echo "1) Heart Rate (heart_rate.log)"
    echo "2) Temperature (temperature.log)"
    echo "3) Water Usage (water_usage.log)"
    read -p "Enter choice (1-3): " choice

    if [ "$choice" = "1" ]; then
        logfile="heart_rate.log"
        logname="Heart Rate"
        break
    elif [ "$choice" = "2" ]; then
        logfile="temperature.log"
        logname="Temperature"
        break
    elif [ "$choice" = "3" ]; then
        logfile="water_usage.log"
        logname="Water Usage"
        break
    else
        echo "Invalid input. Please enter 1, 2, or 3."
    fi
done

echo "You selected: $logname ($logfile)"
