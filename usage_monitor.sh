#!/bin/bash

#define log file and values
LOG_FILE="/var/log/cpu_usage.log"
DISK_THRESHOLD=90

DATE=$(date +'%Y-%m-%d %H:%M:%S')

CPU_USAGE=$(top -bn1 | grep "%Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

#log cpu usage with a timestamp
echo "$DATE - CPU Usage: $CPU_USAGE%" >> $LOG_FILE

#check disk usage
DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g') 
if [ $DISK_USAGE -gt $DISK_THRESHOLD ]; then
	ALERT="Disk usage is high: $DISK_USAGE%"
	echo "$DATE - ALERT: $ALERT" >> $LOG_FILE
else
	echo "Disk usage is normal: $DISK_USAGE" >> $LOG_FILE
fi

LAST_LOGIN=$( last | head -n 2)

echo "Last logins occured $(date):" >> $LOG_FILE
echo $LAST_LOGIN >> $LOG_FILE
echo "--------------------" >> $LOG_FILE

cat $LOG_FILE
