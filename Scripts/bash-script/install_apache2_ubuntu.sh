# Bash script to Install Apache on Ubuntu:

#!/bin/bash

# Check if Apache is already installed
if dpkg -l | grep -q apache2 ; then
        echo "Apache2 service is already installed"
else
        echo "Apache2 service is not installed"
        echo ""
        echo "Installation is started........."
        
        #update the package list
        sudo apt get update
        
        #Install Apache2
        sudo apt get install -y apache2
        
        #start apache service
        sudo systemctl start apache2
        
        #Enable apache to start on boot
        sudo systemctl enable apache2
        
        # Verify Apache status
        echo "Displaying Apache service status"
        sudo systemctl status apache2 --no-pager
        
        echo "Apache has been installed and started"
fi

#------------------------------------#

#script execute
chmod +x install_apache.sh

#Run the script
./install_apache.sh

#Explanation:
# -q: Quiet mode, no output is printed to the terminal
# -l: List packages
# -w: Match whole word 
#** --no-pager ""if you add the --no-pager option, the output is displayed directly to the terminal and 
#     no pager is used. This means you will see the full output without having to scroll. 



## Short form the script: 

if dpkg -l | grep -q apache2 ; then
        echo "Apache2 service is already installed"
else
        echo "Apache2 service is not installed"
fi