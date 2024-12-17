#!/bin/bash

LOG_FILE="/var/log/cpu_usage.log"
DATE=$(date +'%Y-%m-%d %H:%M:%S')
CPU_USAGE=$(top -bn1 | grep "%Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
echo "$DATE - CPU Usage: $CPU_USAGE%" >> $LOG_FILE
