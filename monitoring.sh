#!/bin/bash

Architecture=$(uname -a)
Physical_CPU=$(lscpu | grep "^Socket" | awk '{print $2}')
Virtual_CPU=$(nproc)
RAM_total=$(free | grep "^Mem:" | awk '{print $2}')
RAM_used=$(free | grep "^Mem:" | awk '{print $3}')
RAM_percent=$(awk "BEGIN {print $RAM_used / $RAM_total * 100}")
storage_total=$(df -h -m --total | grep "^total" | awk '{print $2}')
storage_used=$(df -h -m --total | grep "^total" | awk '{print $3}')
storage_percent=$(awk "BEGIN {print $storage_used / $storage_total * 100}")
CPU_id=$(vmstat | grep -v -e "procs" -e "r" | awk '{print $15}')
CPU_utilization=$(awk "BEGIN {print 100 - $CPU_id}")
reboot_date=$(who -b | awk '{print $3}')
reboot_time=$(who -b | awk '{print $4}')
LVM_count=$(ls /dev/mapper | wc -w)
connection_num=$(ss -tn state established | grep -v "^Recv-Q" | wc -l)
user_num=$(w | grep "users" | awk '{print $5}')
ip_v4=$(ip -4 a | grep inet | tr '\n' ' ' | awk '{print $2}' | tr '/' '\n' | head -n 1)
sudo_num=$(cat /var/log/sudo/sudo.log | grep COMMAND | wc -l)
date_now=$(date)

if [ "$LVM_count" -gt 2 ]; then
    LVM_use="yes"
else
    LVM_use="no"
fi

wall "
Broadcast message from root@tsugimot42 (tty1) ($date_now):

    #Architecture: $Architecture
    #Physical CPU: $Physical_CPU
    #vCPU: $Virtual_CPU
    #Memory Disk: $RAM_used/$RAM_total ($RAM_percent%)
    #Disk Usage: $storage_usedMB/$storage_totalMB ($storage_percent%)
    #CPU load: $CPU_utilization%
    #Last boot: $reboot_date $reboot_time
    #LVM use: $LVM_use
    #TCP Connections: $connection_num ESTABLISHED
    #User log: $user_num
    #Network: IP $ip_v4
    #Sudo: $sudo_num cmd
"
