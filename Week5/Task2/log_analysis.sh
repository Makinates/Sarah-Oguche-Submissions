#!/bin/bash

# Script setup and argument parsing
LOG_FILE=""
REPORT_FILE="report.json"
ERROR_CODES=(500 501 502 503 504)

while getopts "l:r:" opt; do
  case $opt in
    l) LOG_FILE="$OPTARG" ;;
    r) REPORT_FILE="$OPTARG" ;;
    *) echo "Usage: $0 -l log_file [-r report_file]" && exit 1 ;;
  esac
done

if [[ -z "$LOG_FILE" ]]; then
  echo "Log file is required. Usage: $0 -l log_file [-r report_file]"
  exit 1
fi

# Function for error analysis
error_analysis() {
  echo "Analyzing errors..."
  local errors=$(awk '{print $9}' "$LOG_FILE" | grep -E '^[5-9][0-9]{2}$')
  local error_count=$(echo "$errors" | wc -l)
  local error_details=$(echo "$errors" | sort | uniq -c | sort -nr)
  
  echo "{\"error_count\": $error_count, \"error_details\": ["
  while read -r count code; do
    echo "{\"code\": \"$code\", \"count\": $count},"
  done <<< "$error_details" | sed '$ s/,$//'
  echo "]},"
}

# Function for traffic analysis
traffic_analysis() {
  echo "Analyzing traffic..."
  local daily_traffic=$(awk '{print $4}' "$LOG_FILE" | cut -d: -f1 | uniq -c | sort -nr)
  
  echo "\"traffic\": ["
  while read -r count date; do
    echo "{\"date\": \"$date\", \"count\": $count},"
  done <<< "$daily_traffic" | sed '$ s/,$//'
  echo "]"
}

# JSON Generation for Report
generate_report() {
  echo "{"
  echo "$(error_analysis)"
  echo "$(traffic_analysis)"
  echo "}"
}

# Main execution
generate_report > "$REPORT_FILE"
echo "Report generated at $REPORT_FILE"


#Usage
#Make the script executable:
#chmod +x log_analysis.sh

#Run the script:
#./log_analysis.sh -l /path/to/access.log [-r /path/to/output/report.json]
