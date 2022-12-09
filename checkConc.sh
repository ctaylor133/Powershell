#!/bin/bash

while :; do
CONC1=`/usr/bin/links -dump http://10.181.248.3:8161/queues.jsp | /usr/bin/tail -14 | /usr/bin/head -9 | /usr/bin/cut -c1-67 | sed '/^[[:space:]]*$/d' |  sed '/^$/d' | grep onelink | cut -c19-25 | sed 's/ //g'`

CONC2=`/usr/bin/links -dump http://10.181.248.4:8161/queues.jsp | /usr/bin/tail -14 | /usr/bin/head -9 | /usr/bin/cut -c1-67 | sed '/^[[:space:]]*$/d' |  sed '/^$/d' | grep onelink | cut -c19-25 | sed 's/ //g'`


echo "`date +'%m-%d %H:%M:%S'` - Conc1: $CONC1      Conc2: $CONC2"
sleep 5
done
