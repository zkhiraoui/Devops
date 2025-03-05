#!/bin/bash

# Check if arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <log_file> <server_type>"
    echo "Server types: nginx, apache, httpd"
    exit 1
fi

LOG_FILE="$1"
SERVER_TYPE="$2"

# Check if log file exists
if [[ ! -f "$LOG_FILE" ]]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

# Function to format and print results in a table
format_output() {
    printf "%-20s | %s\n" "Item" "Requests"
    printf "%-20s | %s\n" "--------------------" "--------"
    while read count item; do
        printf "%-20s | %d\n" "$item" "$count"
    done
}

# Top 10 IP addresses making requests
echo "Top 10 IPs making requests:"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -10 | format_output

# Top 10 most requested URLs
echo -e "\nTop 10 most requested URLs:"
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -10 | format_output

# HTTP Status Code Distribution
echo -e "\nHTTP Status Code Distribution:"
awk '{print $9}' "$LOG_FILE" | grep -Eo "[0-9]{3}" | sort | uniq -c | sort -nr | format_output

# Top 10 User Agents
echo -e "\nTop 10 User Agents:"
awk -F '"' '{print $6}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -10 | format_output