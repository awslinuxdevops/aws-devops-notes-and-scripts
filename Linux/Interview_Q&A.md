1. 



13. What is a daemon in Linux?
- A daemon is a background process that runs continuously and typically starts at boot. 


20. What are inodes in Linux?
- Inodes are data structures that store information about files on a Linux file system. Each inode contains metadata about a file, such as its permissions, ownership, and location on disk.

21. What is the purpose of the crontab in Linux?
- Crontab is used to schedule commands to be executed periodically. It holds the list of scheduled tasks. 

22. Explain the purpose of the sshd service?
- The sshd service is used to manage secure shell connections. It allows users to securely access a 
Linux system over a network. "[port No: 21]"

23. What is the purpose of the iptables?
- The iptables is a firewall that is used to filter network traffic. It is used to control
incoming and outgoing network traffic based on a set of predefined rules.

24. What are environment variables in linux?
- An environment variables is a named value that can affect the way running processes behave on a computer. 
They are part of the environment in which a process runs. 

25. What is the difference between wget and curl?
- Both are command-line tools for transferring data over the network. wget is simpler and designed to download files, whereas curl offers more protocols and features.

26. How do you check disk usage in Linux?
- Disk usage can be checked using the df and du commands.

27. What is the purpose of the xargs command?
- The xargs command is used to build and execute commands from standard input. It is used to
process input line by line.
``` find . - name "*.txt" | xargs rm ```

28. What is the difference between yum and rpm?
- yum is a front-end tool for package management that automatically resolves dependencies,
whereas rpm is a lower-level tool that manages individual packages without automatically handling dependencies.

29. What is a Linux service?
- A Linux service is a program that runs in the background and provides a specific function or
service to the system.

30. Explain the purpose of the /etc/fstab file.
- /etc/fstab is a system configuration file that contains information about different file systems and how they are mounted. 

***
31. Explain the use of the sed command.
- The sed command is a stream editor that is used to perform operations on text files. It is
used to search, replace, and manipulate text.
```
sed 's/old/new/g' file.txt
```
32. What is the purpose of the netstat command?
- The netstat command is used to display network socket information. It is used to view
network connections, routing tables, and interface statistics.

33. Explain the use of the `awk` command?
- The `awk` command is a programming language that is used for pattern scanning and processing.
```
awk '{print $2}' date.txt
```

34. Explain the purpose of the nslookup command.
- The nslookup command is used to query DNS servers and retrieve information about domain names and IP addresses.

***
35. What is the difference between `ssh` and `scp`?
- `ssh` is a secure shell that allows remote login and command execution, whereas `scp
` is a secure copy that allows secure file transfer.

36. What is the difference between iptables and firewalls?
- iptables is a firewall configuration tool that is used to manage network traffic, whereas a  
firewall is a network security system that controls incoming and outgoing network traffic.

37. What are runlevels in Linux?
- Runlevels are predefined modes, that a linux system can run in, each with a specific purposes, like single-user mode, multi-user mode, GUI mode, etc. Check using runlevel command.

* 0: Halt/Shut down the system
* 1: Single-user mode
* 2: Multi-user mode without networking
* 3: Multi-user mode with networking
* 4: User-defined runlevel
* 5: X11 mode (GUI mode)
* 6: Reboot the system

38. Explain the purpose of the rsync command?
- rsync is used for fast and versatile file copying, both locally and remotely, it's commonly used for backups and mirroring. 

39. What are system logs and where are they located?
- System logs record various activities of the operating system. 
They are typically located in the /var/log directory. 

40. What is the purpose of the /etc/sysconfig directory?
- The /etc/sysconfig directory contains configuration files for system services and settings.
- It is used to store configuration files for system services and settings.

41. What are the common network configuration files in Linux?
- The common network configuration files in Linux are:
- /etc/hosts
- /etc/network/interfaces
- /etc/resolv.conf
- /etc/sysconfig/network-scripts
- /etc/sysconfig/network-scripts/ifcfg-eth0

***
42. What is the purpose of the `dmesg` command?
- dmesg displays the kernel-related messages and helps in troubeshooting hardware and driver related issues.

43. nice and renice value?
- nice’ Command: This command is used to start a new process with a specific priority, known as the “nice value.” A higher nice value lowers the process’s priority, while a lower (negative) nice value increases it. Processes with higher priority receive more CPU time.
'-20 to 19" 

- renice: This command is used to change the nice value of a running process. It allows 
you to adjust the priority of a process that is already running.

44. Explain the purpose of the dig command?
- dig (Domain information Groper) is a command-line tool for performing DNS lookups and troubleshooting DNS issues.

45. How do you find the hardware details of your system?
- You can use the following commands to find the hardware details of your system:
- lspci
- lscpu
- lshw
- lsblk
- dmidecode
- cat /proc/cpuinfo
- cat /proc/meminfo


46. Explain the purpose of the tr command?
- tr is used for translating or deleting characters from standard input and writing to standard output. 
"tr - translate command" 

