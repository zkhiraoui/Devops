# log-archive.sh

## Description

`log-archive.sh` is a simple bash script to archive log files or directories into compressed `tar.gz` archives. This is useful for regularly backing up and compressing logs to save disk space and keep your system organized. The script can archive either a single log file or an entire directory of logs.

## Prerequisites

*   **Bash:**  The script is written in bash, so you need to have bash installed on your system (most Unix-like systems have it by default).
*   **tar:** The script uses the `tar` command for creating archives. `tar` is a standard utility on Unix-like systems.

## Usage

1.  **Save the script:** Save the script to a file named `log_archive.sh` (or any name you prefer with the `.sh` extension).
2.  **Make it executable:**  You need to make the script executable so you can run it from the command line. Open your terminal and run:

    ```bash
    chmod +x log_archive.sh
    ```

3.  **Run the script:** Execute the script from your terminal, providing the path to the log file or directory you want to archive as an argument:

    ```bash
    ./log_archive.sh <log-path>
    ```

    Replace `<log-path>` with the actual path to the log file or directory you want to archive.

    *   **To archive a directory (e.g., `/var/log/nginx`):**

        ```bash
        ./log_archive.sh /var/log/nginx
        ```

    *   **To archive a single log file (e.g., `/var/log/auth.log`):**

        ```bash
        ./log_archive.sh /var/log/auth.log
        ```

## Configuration

*   **`ARCHIVE_DIR="log_archives"`:**  At the beginning of the script, you'll find a configuration variable:

    ```bash
    ARCHIVE_DIR="log_archives"
    ```

    This variable defines the name of the directory where the archive files will be stored. By default, it is set to `log_archives`. You can change this value directly in the script if you want to store your archives in a different directory.

## Output

When you run the script, it will:

1.  Create a directory named `log_archives` (or the name you configured in `ARCHIVE_DIR`) in the **same directory where you run the script**, if it doesn't already exist.
2.  Create a compressed `tar.gz` archive file inside the `log_archives` directory. The archive file will be named using the following format:

    `logs_archive_YYYYMMDD_HHMMSS.tar.gz`

    Where:
    *   `YYYYMMDD` is the year, month, and day when the archive was created.
    *   `HHMMSS` is the hour, minute, and second when the archive was created.

3.  Print messages to the terminal indicating the progress and success or failure of the archiving process.

**Example Output:**

./log_archive.sh /var/log/auth.log
Archiving '/var/log/auth.log' to 'log_archives/logs_archive_20250220_103000.tar.gz'...
Logs archived successfully to 'log_archives/logs_archive_20250220_103000.tar.gz'



After running the script, you will find the `logs_archive_20250220_103000.tar.gz` file in the `log_archives` directory, located in the same directory where you executed the `log_archive.sh` script.

## Error Handling

The script includes basic error handling:

*   **Missing log path argument:** If you run the script without providing a log file or directory path, it will display an error message and usage instructions.
*   **Log path does not exist:** If the provided log path does not exist, the script will display an error message.
*   **Archive creation errors:** If there is an error during the archive creation process (e.g., permissions issues), the script will display an error message.

## Further Improvements (Optional)

This is a basic log archiving script. You could extend it with more features, such as:

*   **Scheduling:** Use `cron` or `systemd timers` to schedule the script to run automatically at regular intervals.
*   **Log Rotation:** Implement log rotation within the script to manage older archives (e.g., delete archives older than a certain period).
*   **Customizable Archive Name:** Allow users to customize the archive name format.
*   **More Compression Options:** Add options to use different compression algorithms (e.g., `bzip2`, `xz`).
*   **Logging:** Add more detailed logging to a separate log file.

---

This `README.md` provides a good starting point for users to understand and use your `log-archive.sh` script. You can further enhance it based on user feedback and any additional features you add to the script.
