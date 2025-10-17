#!/bin/bash

SRC="/var/log"
DEST="/backup/$(date +%F)
mkdir -p $DEST
find $SRC -type f -name "*.log" -exec gzip {} \;
cp $SRC/*.gz $DEST/
echo "Backup Completed on $(date)"

