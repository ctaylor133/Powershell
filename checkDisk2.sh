#!/usr/bin/expect -f
## ADD DB to the list as well

# Read server IP addresses or hostnames from concentratorIPs.txt
set file [open "/home/user/scripts/IPs.txt"]
set servers [split [read $file] "\n"]
close $file

# SSH username and password (replace with your credentials)
set username "user"
set password "fixme"

# Loop through the servers and check disk space
foreach server $servers {
    if { $server != "" } {
        spawn ssh -o StrictHostKeyChecking=no $username@$server "df -h && echo " " && echo SWAP SPACE && hostname && (free -m | awk '/Swap/ {print \$2}') && echo " ""
        expect "password:"
        send "$password\r"
        expect {
            "Permission denied" {
                puts "Failed to log in to $server."
                exit 1
            }
            "df -h" {
                puts "Checking disk space on $server..."
                send "exit\r"
                expect eof
            }
        }
    }
