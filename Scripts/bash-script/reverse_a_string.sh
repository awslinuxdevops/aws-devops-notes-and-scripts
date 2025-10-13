####  Write a script to reverse a string.

#!/bin/bash

str="$1"
reversed=""
len=${#str}

for (( i=$len-1; i>0; i-- )); do
    reversed+=${str:$i:1}
done

echo " Reversed string: $reversed"

##### Explanation: 
* $(#str) gives the length of the string
* $(str:$i:1) extracts each character from the string in reverse order.

