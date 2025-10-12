## Shell script to find factorial of number

# using while loop:

echo "Enter the factorial number: "
read num

fact=1
counter=$num

while [ $counter -gt 0 ]
do
    fact=$((fact * counter))
    counter=$((counter - 1))
done

echo "Factorial of $num is $fact"
==========================================

# using for loop:

#/bin/bash
echo "enter the factorial number: "
read num

fact=1

for ((i=2;i<=num;i++))
do
fact=$((fact * i))
done
echo "Factorial of $num is $fact"  
=========================================

# Test if file exists

#!/bin/bash

MyFile=cars.txt
if [ -f "$MyFile" ]; then
    echo "$MyFile is exists."
else
    echo "$MyFile does not exits."
fi
==========================================

#!/bin/bash
SRC_DIR=/path/to/source/directory
DST_DIR=/path/to/destination/directory

if [ ! -d "$DST_DIR" ]; then
    mkdir -p "$DST_DIR"
fi

for file in "$SRC_DIR"/*; do
    cp "$file" "$DST_DIR"
done

if [ ! -d "$SRC_DIR" ]; then
    echo "Error: Source directory does not exist"
    exit 1
fi 





