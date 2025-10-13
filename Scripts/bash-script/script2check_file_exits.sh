#### Write a script to check if a file exists.

#!/bin/bash 

FILE="$1"

if [ -e "$FILE" ]; then
   if [ -d "$FILE" ]; then
      echo "$FILE is a directory."
   elif [ -f "$FILE" ]; then
      echo "$FILE is a regular file."
   else
      echo "$FILE exists, but it's neither a directory nor a regular file."
   fi
else
   echo "$FILE does not exist."
fi 

##### Explanation: 
* -e Checks if the file exists.
* -f Checks if the file is a regular file
* -d Checks if the file is a directory






