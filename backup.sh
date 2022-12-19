#!/bin/bash
export PATH=$PATH:/usr/bin:/bin:/usr/sbin

WINPASSWORD=fix_me
MYSQLPASSWORD=fix_me

cd /mysqldata/backups

TODAY=`/bin/date +%a`
echo "Backups starting at `date`" > /tmp/backup-$TODAY.log
mysqldump --opt -u root -p$MYSQLPASSWORD onelink | /bin/bzip2 >  onelink-$TODAY.sql.bz2
echo "Backup completed in /mysqldata/backups" >> /tmp/backup-$TODAY.log
ls -l /mysqldata/backups >> /tmp/backup-$TODAY.log

echo "Mounting windows backup drive" >> /tmp/backup-$TODAY.log

mount -t cifs -o username=username,password=$WINPASSWORD,domain=fix.me //fqdn_of_backup_srv/directory /mnt/tape
echo "Copying onelink backup to windows tape drive" >> /tmp/backup-$TODAY.log

sleep 2
cp onelink-$TODAY.sql.bz2 /mnt/tape/onelink.sql.bz2
echo "Copying to windows drive completed" >> /tmp/backup-$TODAY.log

ls -l /mnt/tape >> /tmp/backup-$TODAY.log

echo  "Unmounting windows drive" >> /tmp/backup-$TODAY.log

sleep 2
umount /mnt/tape
sleep 2
echo "Backups completed at `date`" >> /tmp/backup-$TODAY.log

#mail -s "Backup completed" email.com < /tmp/backup-$TODAY.log
