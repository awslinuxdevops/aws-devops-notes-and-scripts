#### Write a script to check if a number is prime.

#!/bin/bash

num=$1
if [ "$num" -lt 2 ]; then
    echo "$num is not a prime number."
    exit 0
fi

for ((i=2; i*i<=num; i++)); do
    if ((num % i == 0)); then
       echo "$num is not a prime number."
       exit 0
    fi
done
echo "$num is a prime number."