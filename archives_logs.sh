#!/bin/bash
# archive_logs.sh - Simple log archiver

echo "Select log to archive:"
echo "1) heart_rate_log.log"
echo "2) temperature_log.log"
echo "3) water_usage_log.log"
read -p "Enter choice (1-3): " choice

if [ "$choice" -eq 1 ]; then
    log="heart_rate_log.log"
    folder="heart_data_archive"
    name="heart_rate"
elif [ "$choice" -eq 2 ]; then
    log="temperature_log.log"
    folder="temperature_data_archive"
    name="temperature"
elif [ "$choice" -eq 3 ]; then
    log="water_usage_log.log"
    folder="water_data_archive"
    name="water_usage"
else
    echo "Invalid choice! Please enter 1, 2, or 3."
    exit 1
fi

# Check if log file exists
if [ ! -f "$log" ]; then
    echo "Error: $log not found!"
    exit 1
fi

# Create folder if missing
mkdir -p "$folder"

# Add timestamp and move file
time=$(date +"%Y-%m-%d_%H-%M-%S")
mv "$log" "$folder/${name}_$time.log"

# Create new empty log file
touch "$log"

echo "Successfully archived to $folder/${name}_$time.log"


