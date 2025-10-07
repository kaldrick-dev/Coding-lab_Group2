#!/bin/bash

echo "Select log to archive:"
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"
read -p "Enter choice (1-3): " choice

# Decide which file and folder to use
if [ "$choice" == "1" ]; then
    logfile="hospital_data/active_logs/heart_rate.log"
    archivefolder="hospital_data/archives/heart_data_archive"
    newname="heart_rate"
elif [ "$choice" == "2" ]; then
    logfile="hospital_data/active_logs/temperature.log"
    archivefolder="hospital_data/archives/temp_data_archive"
    newname="temperature"
elif [ "$choice" == "3" ]; then
    logfile="hospital_data/active_logs/water_usage.log"
    archivefolder="hospital_data/archives/water_data_archive"
    newname="water_usage"
else
    echo "Invalid choice!"
    exit 1
fi

# Check that log file exists
if [ ! -f "$logfile" ]; then
    echo "Error: Log file not found!"
    exit 1
fi

# Make sure the archive folder exists
mkdir -p "$archivefolder"

# Add timestamp
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
newfile="${archivefolder}/${newname}_${timestamp}.log"

echo "Archiving $logfile ..."
mv "$logfile" "$newfile"

# Create a new empty log file
touch "$logfile"

echo "✅ Successfully archived to $newfile"
