## Pratice Shell Scripting

find .  -type f -size +4096c
find .  -type f -size +4096c -exec ls -l {} \;


find . -tpye f ! -name ".*" | wc -l

find . -type f -name ".txt" | wc -l

find -maxdepth 1 -type f | wc -l

find -maxdepth 1 -type f ! -name ".*" | wc -l

find -maxdepth 1 -type f -name "*.txt" | wc -l


find directory -iname "*.txt" -mtime -n -print

find directory -iname "*.txt" -mtime -2 -print

du -a 2>/dev/null | sort -n -r

du -a 

=================================================================

#!/bin/bash

#1 variable
name=Tom
age=25

echo $name $age

#2 display user input
#!/bin/bash
read num
echo "The number is: $num"

#3 Read user input and prompt message
#!/bin/bash

read -p "Enter your name: " name
echo "The number is: $num" 

#4 Concatenating Multiple variables
#!/bin/bash

name='My name is Tom."
















