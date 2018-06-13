#!/bin/bash

#set the log location here
log='/tmp/sa28'
#set time format to 24h clock
LC_ALL="C"

#  sar -u             #cpu usage
#  sar -r             #mem/swap usage
#  sar -q             #load average for 1 minute
#  sar -I SUM         #irq/s
#  sar -c             #proc/s - total number of processes created per second
#  sar -w             #total number of context switches per second
#  sar -W             #swap activity
#  sar -b             #i/o transfers to disks

(for i in -u -r -q "-I SUM" -C -w -W -b;
  do sar -s 14:00:00 -e 18:00:01 -f $log $i | tail -n +4 | head -n -1;
  echo "===========";
  sleep 1;
done) | awk -f /home/user/gnuplot/2-report-awk.sh |  head -n -1 | tail -n +2 > /home/user/gnuplot/4-output-data
