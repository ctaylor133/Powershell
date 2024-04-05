#!/bin/bash
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin
MYSQL_USER="onelink"
MYSQL_PASS="fixme"
MYSQL_HOST=$(grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' /opt/onelink/etc/database.properties | awk 'NR==1{print}')
MYSQL_CMD="/usr/bin/mysql -u $MYSQL_USER -p$MYSQL_PASS"
SLAVE_QUERY="select host from mysql.user where user='replicant';"

# Execute the MySQL command and process its output with awk
SLAVE=$($MYSQL_CMD -e "$SLAVE_QUERY" 2>&1 | awk -F'[ :]' '/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/')

SLAVE_RUNNING=`echo 'show slave status\G' | $MYSQL_CMD -h $SLAVE  | /bin/grep "Slave_SQL_Running:" | /usr/bin/cut -d: -f2| /bin/sed 's/ //g'`
echo $SLAVE_RUNNING

if [ "X$SLAVE_RUNNING" == "XYes" ]
then
   echo "Slave is running"
else
   echo "Slave is stopped"
   echo 'show slave status\G' | $MYSQL_CMD

fi
