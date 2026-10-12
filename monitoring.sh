#!/bin/bash

Architecture=$(uname -a)
Physical_CPU=$(lscpu | grep "^CPU(s):" | awk '{print $2}')
Virtual_CPU=$()
RAM_total=$(free | grep "^Mem:" | awk '{print $2}')
RAM_used=$(free | grep "^Mem:" | awk '{print $3}')




echo $Architecture