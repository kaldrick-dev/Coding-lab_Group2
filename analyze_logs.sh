#!/bin/bash


while  true; do

    echo "Select log file to analyze:"
    echo "1) Heart Rate (heart_rate.log)"
    echo "2) Temperature (temperature.log)"
    echo "3) Water Usage (water_usage.log)"
    read -p "Please enter choice (1-3): " choice

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

mkdir -p reports
REPORT_FILE="reports/analysis_report.txt"

FILE="hospital_data/active_logs/$logfile"

if [ ! -f "$FILE" ]; then
    echo "⚠️ Error: Log file not found: $FILE"
    exit 1
fi

echo "------------------------------" >> "$REPORT_FILE"
echo "Analysis Report - $(date)" >> "$REPORT_FILE"
echo "Log analyzed: $logname ($FILE)" >> "$REPORT_FILE"

awk '{print $1}' "$FILE" | sort | uniq -c >> "$REPORT_FILE"

FIRST=$(head -n 1 "$FILE" | awk '{print $2, $3}')
LAST=$(tail -n 1 "$FILE" | awk '{print $2, $3}')
echo "First entry: $FIRST" >> "$REPORT_FILE"
echo "Last entry: $LAST" >> "$REPORT_FILE"

echo "------------------------------" >> "$REPORT_FILE"
echo "✅ Analysis complete. Results saved to $REPORT_FILE"
