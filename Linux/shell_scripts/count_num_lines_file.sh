#### Write a script to count the number of lines in a file.

#!/bin/bash

FILE="$1"

if [ -f "$FILE" ]; then
   line_count=$(wc -l < "$FILE")
   echo "The file $FILE has $line_count lines."
else
   echo "The $FILE is not a valid file ."
fi

##### Explanation: 
* -"wc -l": Command to count the number of lines in a file.
* -the < "$FILE" syntax makes "wc" read from the file directly without showing the filename.
* -"f" Checks if the file is a regular file.  
