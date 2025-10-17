#!/bin/bash
THRESHOLD=80
df -h | awk 'NR>1 {print $1,$5}' | while read disk usage
do
  usage_value=${usage%?}
  if [ $usage_value -ge $THRESHOLD ]; then
    echo "Alert: Disk usage on $disk is ${usage}%" | mail -s "Disk Alert" admin@example.com
  fi
done
