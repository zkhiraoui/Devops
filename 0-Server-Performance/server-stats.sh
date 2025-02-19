#!/bin/bash
# Server Statistics Analysis Script This script provides comprehensive server performance metrics Author: Your Name 
# Version: 1.0.0 Set script to exit on error
set -e
# Color definitions
RED='\033[0;31m' GREEN='\033[0;32m' YELLOW='\033[1;33m' NC='\033[0m' # No Color
# Function to print section headers
print_header() {
    echo -e "${YELLOW}----------------------------------------"
    echo "$1"
    echo -e "----------------------------------------${NC}"
}
# Function to calculate percentage
calc_percentage() {
    echo "scale=2; $1 * 100 / $2" | bc
}
# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}
# Check for required commands
check_requirements() {
    local missing_requirements=0
    
    if ! command_exists mpstat; then
        echo -e "${RED}Error: mpstat is not installed. Please install sysstat package.${NC}"
        missing_requirements=1
    fi
    
    if ! command_exists bc; then
        echo -e "${RED}Error: bc is not installed. Please install bc package.${NC}"
        missing_requirements=1
    fi
    
    if [ $missing_requirements -eq 1 ]; then
        echo -e "${YELLOW}Install required packages with: sudo apt-get install sysstat bc${NC}"
        exit 1
    fi
}
# Function to get system information
get_system_info() {
    print_header "SYSTEM INFORMATION"
    echo -e "${GREEN}OS Version:${NC} $(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)"
    echo -e "${GREEN}Kernel Version:${NC} $(uname -r)"
    echo -e "${GREEN}Uptime:${NC} $(uptime -p)"
    echo -e "${GREEN}Last Boot:${NC} $(who -b | awk '{print $3,$4}')"
}
# Function to get CPU usage
get_cpu_usage() {
    print_header "CPU USAGE"
    echo -e "${GREEN}CPU Usage Summary:${NC}"
    mpstat 1 1 | awk '/Average:/ {printf "CPU Usage: %.2f%%\n", 100-$NF}'
}
# Function to get memory usage
get_memory_usage() {
    print_header "MEMORY USAGE"
    free -h | awk -v green="${GREEN}" -v nc="${NC}" '
    /^Mem:/ {
        print green"Total Memory: "nc $2
        print green"Used Memory: "nc $3
        print green"Free Memory: "nc $4
        printf green"Memory Usage: "nc "%.2f%%\n", $3/$2*100
    }'
}
# Function to get disk usage
get_disk_usage() {
    print_header "DISK USAGE"
    df -h / | awk -v green="${GREEN}" -v nc="${NC}" '
    NR==2 {
        print green"Total Space: "nc $2
        print green"Used Space: "nc $3
        print green"Free Space: "nc $4
        print green"Disk Usage: "nc $5
    }'
}
# Function to get top processes
get_top_processes() {
    print_header "TOP 5 CPU-CONSUMING PROCESSES"
    ps aux --sort=-%cpu | head -6
    print_header "TOP 5 MEMORY-CONSUMING PROCESSES"
    ps aux --sort=-%mem | head -6
}
# Function to get network statistics
get_network_stats() {
    print_header "NETWORK STATISTICS"
    echo -e "${GREEN}Network Interfaces:${NC}"
    ip -br addr show
}
# Main execution
main() {
    # Check requirements first
    check_requirements
    
    # Clear screen
    clear
    
    # Print script header
    echo -e "${GREEN}Server Statistics Analysis Script${NC}"
    echo "Running analysis..."
    echo
    
    # Get all statistics
    get_system_info
    get_cpu_usage
    get_memory_usage
    get_disk_usage
    get_top_processes
    get_network_stats
    
    # Load Average
    print_header "LOAD AVERAGE"
    uptime | awk -v green="${GREEN}" -v nc="${NC}" '{print green"Load Average (1,5,15 min): "nc $(NF-2), $(NF-1), 
$NF}'
    
    # Currently Logged In Users
    print_header "LOGGED IN USERS"
    who
    
    # Check if we have access to auth.log
    if [ -r "/var/log/auth.log" ]; then
        print_header "RECENT FAILED LOGIN ATTEMPTS"
        grep "Failed password" /var/log/auth.log 2>/dev/null | tail -5
    fi
    
    # Check if we have access to syslog
    if [ -r "/var/log/syslog" ]; then
        print_header "RECENT SYSTEM MESSAGES"
        tail -5 /var/log/syslog
    fi
}
# Run main function
main
