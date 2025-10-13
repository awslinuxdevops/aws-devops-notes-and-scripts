#  This is Backup shell scripts:


#!/bin/bash

# Variables
SOURCE_DIR="/path/to/source/directory"   # Directory to back up
BACKUP_DIR="/path/to/backup/directory"   # Directory to store the backup
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")       # Current timestamp
BACKUP_FILE="backup_$TIMESTAMP.tar.gz"   # Backup file name

# Create the backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Perform the backup
tar -czf "$BACKUP_DIR/$BACKUP_FILE" "$SOURCE_DIR"

# Verify the backup
if [ $? -eq 0 ]; then
    echo "Backup successful: $BACKUP_DIR/$BACKUP_FILE"
else
    echo "Backup failed!"
    exit 1
fi

# Optional: Delete backups older than 7 days
find "$BACKUP_DIR" -type f -name "backup_*.tar.gz" -mtime +7 -exec rm {} \;


### Explanation:
Variables:

SOURCE_DIR: The directory you want to back up.
BACKUP_DIR: The location where the backup file will be stored.
TIMESTAMP: Adds a unique timestamp to the backup file to avoid overwriting.
Backup Command:

tar -czf: Creates a compressed archive (.tar.gz) of the specified directory.
Backup Directory Creation:

mkdir -p: Ensures the backup directory exists. If not, it creates it.
Verification:

Checks the exit status of the tar command to ensure the backup was successful.
Cleanup:

Deletes backups older than 7 days using the find command.
How to Use:
Replace /path/to/source/directory with the directory you want to back up.
Replace /path/to/backup/directory with the location where you want to store the backup.
Save the script as backup.sh.
Make the script executable:

chmod +x backup.sh

Run the script:

./backup.sh

====================================================================================================


#!/bin/bash

# Backup script 
echo "Backup process is stated"
backup_dir="/path/to/backup"

mdkir -p %backup_dir

timestamp=$(date + '%Y%m%d_%H%M%S')
backup_file="${backup_dir}/backup_${timestamp}.tar.gz"  
source_dir="/path/to/source"    
tar -czf "${backup_file}" "${source_dir}"

echo "Backup created: ${backup_file}/${backup_filename}"

echo "Backup process is completed"

