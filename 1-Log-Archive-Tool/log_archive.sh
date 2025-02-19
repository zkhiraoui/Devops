#!/bin/bash
# Script to archive logs from a specified directory or file --- Configuration ---
ARCHIVE_DIR="log_archives"
# --- Functions ---
create_log_archive() {
  log_path="$1" # Renamed variable to log_path to represent both file and directory
  if [ -z "$log_path" ]; then
    echo "Error: Log file/directory argument is missing."
    echo "Usage: $0 <log-path>"
    return 1
  fi
  if [ ! -e "$log_path" ]; then # Use -e to check for both files and directories
    echo "Error: Log path '$log_path' does not exist."
    return 1
  fi
  timestamp=$(date +%Y%m%d_%H%M%S)
  archive_name="logs_archive_${timestamp}.tar.gz"
  archive_path="${ARCHIVE_DIR}/${archive_name}"
  # Create the archive directory if it doesn't exist
  mkdir -p "$ARCHIVE_DIR"
  echo "Archiving '$log_path' to '$archive_path'..."
  if [ -d "$log_path" ]; then # Check if it's a directory
    tar -czf "$archive_path" -C "$(dirname "$log_path")" "$(basename "$log_path")"
  elif [ -f "$log_path" ]; then # Check if it's a file
    tar -czf "$archive_path" -C "$(dirname "$log_path")" "$(basename "$log_path")"
  else
    echo "Error: '$log_path' is not a regular file or directory."
    return 1
  fi
  if [ $? -eq 0 ]; then # Check exit status of the last command (tar)
    echo "Logs archived successfully to '$archive_path'"
  else
    echo "Error: Failed to create archive '$archive_path'"
    return 1
  fi
}
# --- Main script ---
if [ "$#" -ne 1 ]; then
  echo "Error: Missing log file/directory argument."
  echo "Usage: $0 <log-path>"
  exit 1 fi log_path="$1" # Renamed variable to log_path create_log_archive "$log_path"
exit 0
