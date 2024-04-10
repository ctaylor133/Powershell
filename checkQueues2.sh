
#!/bin/bash
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin
MYSQL_USER="onelink"
export MYSQL_PASS="fixme"
MYSQL_HOST=$(grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' /opt/onelink/etc/database.properties | awk 'NR==1{print}')
MYSQL_DB="onelink"
MYSQL_CMD="/usr/bin/mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASS $MYSQL_DB"
CONCENTRATOR_QUERY="SELECT * FROM Concentrator;"

# Execute the MySQL command and process its output with awk
CON=$($MYSQL_CMD -e "$CONCENTRATOR_QUERY" 2>&1 | awk -F'[ :]' '/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/ { gsub("//", "", $4); print $4 }')

RESULT=0
/usr/bin/touch IPs.txt
echo "$CON" > IPs.txt
echo "$MYSQL_HOST" >> IPs.txt

echo ""
echo ""
echo "Onelink Packages on App server"
/usr/bin/dpkg -l | grep onelink
echo ""
echo ""

echo ""
echo "Concentrator Monitoring"
echo "======================="
echo ""
echo "Date: `/bin/date`"
echo " "

# Use a while loop to process each IP address
j=1
echo "$CON" | while read -r IP; do
    echo "Concentrator $(printf "%02d" $j)"
    echo "$j `/usr/bin/links -dump http://$IP:8161/index.jsp | grep Devices`"
    j=$((j + 1))
done

echo " "
echo " "
echo "Concentrator 0$j"
echo "================"
echo "Queues: "

j=1
echo "$CON" | while read -r IP; do
    echo "Concentrator $(printf "%02d" $j)"
    echo "$j `/usr/bin/links -dump http://$IP:8161/queues.jsp | /usr/bin/tail -14 | /usr/bin/head -9 | /usr/bin/cut -c1-67 | sed '/^[[:space:]]*$/d' |  sed '/^$/d'`"
    j=$((j + 1))
done

echo ""
echo "ONELINK OPERATING SYSTEM"
echo "======================="
echo "`awk -F '=' 'NR<=5 {print $1, $2}' /etc/os-release`"


echo ""
echo "Appserver Top Processes"
echo "======================="
echo "`/usr/bin/top -b -n 1| head -20`"

echo ""
echo "Appserver Disk Usage"
echo "===================="
echo "`/bin/df -kh`"


echo ""
echo "Concentrator 0$j and Master DB  Disk space"
echo "================"
/home/user/scripts/checkDisk2.sh

#echo ""
#echo "Master Database Disk space"
#echo "================"
#/home/user/scripts/checkDisk2.sh


echo ""
echo "Eligibility Criteria"
echo "===================="
$MYSQL_CMD -N -e "SELECT m.Name as 'Eligibility', p.Name as 'Tier' FROM onelink.MetricCriteria_QualifyingTiers mcq, MetricCriteria m, SlotPatronTier p where mcq.MetricCriteria = m.Id and mcq.QualifyingTiers = p.Id"


echo " "
echo "EGM Count"
echo "========="
TOTAL=`echo "SELECT count(*) from Device where DeviceType='ICard' and ActiveDate is NOT NULL and InActiveDate is NULL and ReplacedDate is NULL;"  | $MYSQL_CMD`

TOTAL=`echo $TOTAL| /usr/bin/cut -d' ' -f2`
QUAR=`echo "select count(*) from Device Where  DeviceType='ICard'  and ActiveDate is NULL   and EndDate is NULL and InActiveDate is NULL and ReplacedDate is NULL" | $MYSQL_CMD`
QUAR=`echo $QUAR | /usr/bin/cut -d' ' -f2`

TOTAL=`expr $TOTAL + $QUAR`


OFFLINE=`echo "SELECT count(*) from Device d, DeviceLinkStatus dls where DeviceType='ICard' and ActiveDate is NOT NULL and InActiveDate is NULL and ReplacedDate is NULL and dls.DeviceId = d.PitaId and dls.Status='OFFLINE';" | $MYSQL_CMD `

OFFLINE=`echo $OFFLINE | /usr/bin/cut -d' ' -f2`
echo "$OFFLINE out of $TOTAL EGMs are OFFLINE"

echo " "
echo "$QUAR of $TOTAL EGMs are Not Activated or in QUARANTINED"

echo " "
NOBM=`echo "SELECT count(*) FROM onelink.ICard ic, Device d where d.DeviceType='ICard' and ic.BonusMethod is NULL and ic.Id = d.Id and d.ActiveDate is NOT NULL and d.InActiveDate is NULL and d.ReplacedDate is NULL" | $MYSQL_CMD`

NOBM=`echo $NOBM | /usr/bin/cut -d' ' -f2`

echo " "
echo " "
echo "$NOBM out of $TOTAL EGMs Have no Bonusing Method defined"

echo " "
echo "MEGA MIC COUNT"
echo "=============="
MEGA=`echo "SELECT count(*) from Device where DeviceType='ICard' and ActiveDate is NOT NULL and InActiveDate is NULL and ReplacedDate is NULL and Platform LIKE '%PAL-264%';" | $MYSQL_CMD`

MEGA=`echo $MEGA | /usr/bin/cut -d' ' -f2`

echo $MEGA

echo " "
echo "MEDIA DISPLAY COUNT"
echo "=============="
MEDIA=`echo "SELECT count(*) from Device where Platform LIKE '%Media%' and DeviceStatus='Authorized'" | $MYSQL_CMD`

MEDIA=`echo $MEDIA | /usr/bin/cut -d' ' -f2`

echo $MEDIA


echo " "
echo "Jackpot Counts Today"
echo "===================="
echo " "
$MYSQL_CMD -N -e "SELECT l.Name As 'Level', count(*) as 'Jackpots' FROM onelink.Jackpot jp, onelink.Level l where EventTime Between SUBDATE(NOW(),1) and NOW() AND jp.LevelId = l.Id group by l.Id"

echo " "
echo "Jackpot Queue Count"
echo "==================="
echo " "
$MYSQL_CMD -N -e "SELECT count(*) as 'Jackpots Queued' FROM onelink.VJPCJackpot jp"

echo " "
echo "Standard Progresive Count"
echo "==================="
echo " "
$MYSQL_CMD --table -e "SELECT COUNT(*) AS RowCount FROM Level WHERE LevelType = 'Standard';"
echo " "
echo " "

echo " "
echo "Bonus Count"
echo "==================="
echo " "
$MYSQL_CMD --table -e "SELECT COUNT(*) AS RowCount FROM Level WHERE LevelType = 'Bonus';"
echo " "
echo " "

/home/user/scripts/checkLogs.pl
RESULT=$?

echo " "
echo "Server NTP Status"
echo "================="
echo "Check Onelink Dashboard "
#/home/user/scripts/checkDate.sh

echo " "
echo " "
echo "Onelink Database Size"
echo "==========================="
$MYSQL_CMD --table -e "select table_schema, Round(Sum(data_length + index_length)/1024000000,2) as 'DB Size in GB' FROM information_schema.tables GROUP BY table_schema;"

echo " "
echo " "

echo " "
echo " "
echo "Mulitcast Channels"
echo "==========================="
$MYSQL_CMD --table -e "select m.Name, Description, count(*)  from Level l, MessageDestination m where InactiveDate is null
and ReplacedDate is null and Status != 'Retired' and l.LevelChannelId=m.Id group by m.Name;"

echo " "
echo " "

echo "IF BLANK THEN MYSQL IS NOT OPTIMIZED"
echo "==========================="
echo " "
/home/user/scripts/checkcnf.sh
echo " "

echo " "
echo "Database Replication Status"
echo "==========================="
echo " "
/home/user/scripts/checkSlaveStatus2.sh
echo " "
echo " "

echo "Appserver Logs"
echo "=============="
/usr/bin/tail -4000 /opt/onelink/logs/appserver.0.log | grep -v -a Activity | grep -v -a OnelinkAdapter


exit $RESULT
