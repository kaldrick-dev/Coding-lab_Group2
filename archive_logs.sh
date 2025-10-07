#!/bin/bash
# -------------------------------------
# archive_logs.sh
# Safely archives hospital monitoring logs
# -------------------------------------

# Exit on any major error
set -e

# Show menu
echo "Select log to archive:"
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"
read -p "Enter choice (1-3): " choice

# Validate input
if ! [[ "$choice" =~ ^[1-3]$ ]]; then
    echo "❌ Invalid input! Please enter 1, 2, or 3."
    exit 1
fi

# Define base directories
active_dir="hospital_data/active_logs"
archive_base="hospital_data/archives"

# Choose log based on user input
case $choice in
    1)
        logfile="hospital_data/active_logs/heart_rate_log.log"
        archive_dir="$archive_base/heart_data_archive"
        name="heart_rate"
        ;;
    2)
        logfile="hospital_data/active_logs/temperature_log.log"
        archive_dir="$archive_base/temp_data_archive"
        name="temperature"
        ;;
    3)
        logfile="hospital_data/active_logs/water_usage_log.log"
        archive_dir="$archive_base/water_data_archive"
        name="water_usage"
        ;;
esac

# Make sure directories exist
if [ ! -d "$archive_dir" ]; then
    echo "ℹ️  Archive folder not found — creating it..."
    mkdir -p "$archive_dir" || { echo "❌ Failed to create $archive_dir"; exit 2; }
fi

# Check if the log file exists
if [ ! -f "$logfile" ]; then
    echo "❌ Log file not found: $logfile"
    echo "Make sure the simulator is running and generating logs."
    exit 3
fi

# Create timestamp
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# Perform the archival
echo "📦 Archiving $logfile..."
mv "$logfile" "$archive_dir/${name}_${timestamp}.log" || {
    echo "❌ Failed to move log file!";
    exit 4;
}

# Create a new empty log file
touch "$logfile" || { echo "❌ Failed to create new log file!"; exit 5; }

echo "✅ Successfully archived $name log!"
echo "📁 Saved as: $archive_dir/${name}_${timestamp}.log"
