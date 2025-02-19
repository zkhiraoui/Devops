# Server Performance Stats Script

This script, `server-stats.sh`, is a Bash script designed to analyze basic server performance statistics on Linux systems.  It provides insights into CPU usage, memory usage, disk usage, and top resource-consuming processes, along with other useful information.

## Project URL

https://roadmap.sh/projects/server-stats

## Features

The script provides the following statistics:

### Core Features
- **CPU Usage**
  - Total CPU utilization percentage
  - Top 5 CPU-consuming processes

- **Memory Usage**
  - Total memory available
  - Used vs Free memory
  - Memory usage percentage
  - Top 5 memory-consuming processes

- **Disk Usage**
  - Total disk space
  - Used vs Free space
  - Disk usage percentage

### Additional Features
- System Information
  - OS version
  - Kernel version
  - System uptime
  - Last boot time
- Load Average (1, 5, and 15 minutes)
- Currently logged-in users
- Recent failed login attempts
- Network interface statistics
- Recent system messages

## Requirements

- Linux-based operating system
- Bash shell
- Required packages:
  - `sysstat` (for mpstat command)
  - `bc` (for percentage calculations)

To install required packages on Debian/Ubuntu:

```sh
sudo apt-get update
sudo apt-get install sysstat bc
```


## Installation

1. Download the script.

2. Make the script executable:

```sh
chmod +x server-stats.sh
```


## Usage

Run the script with:

```sh
./server-stats.sh
```



