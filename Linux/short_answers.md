# Short form of Answers: 

##### nslookup (Name Server lookup):
- **nslookup** is a command-line tool used to query DNS (Domain Name System) servers records.
- nslookup can be used to find the IP address of a domain name, or to find the domain name of an IP address.    
- It's mainly used to DNS troubleshooting and finding information about domain names, IP addresses, and DNS servers.

**Key:**

DNS Lookup: Query DNS records
Reverse DNS Lookup: nslookup can resolve and IP address back to domain name.
DNS Server: nslookup can query DNS servers for information.
DNS Zone: nslookup can query DNS zone records.

**Commands:**
- nslookup example.com
- nslookup -type=MX example.com
- nslookup -type=NS example.com
- nslookup -type=A example.com
- nslookup -type=PTR 192.168.1.1
- nslookup -server 8.8.8.8 example.com
- nslookup 192.168.1.1


##### netstat (Network Statistics):
* netstat is a command-line tool used to display network-related statistics. It primarily shows information about active connections, routing tables, interface statistics, 

* It's used to monitor network connections and troubeshoot networking issues.

**Key:**
* show active TCP connections
* network interface statistics
* Routing table
* Listening Ports

**Commands:**
* netstat -a (show all connections and listening ports)
* netstat -n (show active connections)
* netstat -r (show routing table)
* netstat -i (show interface statistics)
* netstat -p (show listening ports)
* netstat -s (show socket statistics)
* netstat -t (show TCP connections)
* netstat -u (show UDP connections)
* netstat -w (show Windows Sockets statistics)
* netstat -x (show extended information)
* netstat -y (show socket statistics)
* netstat -z (show socket statistics)
* netstat -c (show socket statistics)

#### Set the 'set -x' 
- **set -x** option at the beginning of the script. This option enables debugging mode, which cause Bash to print each command that it executes to the terminal, preceded by a + sign. 

- **set -e** This option will cause bash to exit with an error if any command in the script fails. 





