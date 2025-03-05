# Log Analyzer Script

A versatile shell script for analyzing web server logs from Nginx, Apache, and HTTPD servers. This tool provides insights into server traffic patterns, request distributions, and potential security issues.

## Features

- Supports multiple web server log formats (Nginx, Apache, HTTPD)
- Analyzes top IP addresses making requests
- Shows most requested URLs
- Displays HTTP status code distribution
- Lists top user agents
- Provides additional statistics including error rates
- Easy-to-read formatted output

## Prerequisites

- Unix-like operating system (Linux, macOS)
- Bash shell
- Basic command-line utilities:
  - awk
  - sort
  - uniq
  - grep
  - wc

## Installation

1. Download the script


2. Make the script executable:

```sh

chmod +x log_analyzer.sh

```

3. Run the script 

```sh 

./log_analyzer.sh <log_file> <server_type>

```

Parameters:
- `log_file`: Path to the log file you want to analyze
- `server_type`: Type of web server (nginx, apache, or httpd)



