#!/bin/bash
free -h > ~/backups/freemem/free_mem.txt or cat /proc/meminfo | grep MemFree > ~/backups/freemem/free_mem.txt
df -h | awk '{print $1,$3}' > ~/backups/diskuse/disk_usage.txt
lsof > ~/backups/openlist/open_list.txt887
df -h | awk '{print $1,$5}' > ~/backups/freedisk/free_disk.txt