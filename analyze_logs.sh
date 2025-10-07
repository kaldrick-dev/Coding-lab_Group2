#!/bin/bash
mkdir -p reports
REPORT_FILE="reports/analysis_report.txt"

# Full path to the selected log file in active_logs
FILE="hospital_data/active_logs/$logfile"

# Check if the log file exists
if [ ! -f "$FILE" ]; then
    echo "⚠️ Error: Log file not found: $FILE"
    exit 1
fi

# Append header to the report file
echo "------------------------------" >> "$REPORT_FILE"
echo "Analysis Report - $(date)" >> "$REPORT_FILE"
echo "Log analyzed: $logname ($FILE)" >> "$REPORT_FILE"

# Count occurrences of each device (device ID assumed as first field)
awk '{print $1}' "$FILE" | sort | uniq -c >> "$REPORT_FILE"

# Optional: first and last timestamps (assuming 2nd & 3rd fields are date & time)
FIRST=$(head -n 1 "$FILE" | awk '{print $2, $3}')
LAST=$(tail -n 1 "$FILE" | awk '{print $2, $3}')
echo "First entry: $FIRST" >> "$REPORT_FILE"
echo "Last entry: $LAST" >> "$REPORT_FILE"

# Footer & completion message
echo "------------------------------" >> "$REPORT_FILE"
echo "✅ Analysis complete. Results saved to $REPORT_FILE"
