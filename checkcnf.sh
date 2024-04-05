#!/bin/bash

# Get the IP address from the specified command
MYSQL_HOST=$(grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' /opt/onelink/etc/database.properties | awk 'NR==1{print}')

# SSH username and password
SSH_USER="user"
SSH_PASSWORD="fixme"

# Define the expect script
expect -c "
spawn ssh $SSH_USER@$MYSQL_HOST cat /etc/mysql/mysql.conf.d/zz-aristocrat.cnf | /bin/grep "innodb_buffer_pool"
expect {
  \"*assword\" {
    send \"$SSH_PASSWORD\r\"
    exp_continue
  }
  eof
}
"
