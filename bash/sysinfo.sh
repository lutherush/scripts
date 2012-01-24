#!/bin/bash
clear
printf '********************\n';
printf 'SYSTEM STATUS:\n \n';
printf 'OS: '; uname -sr | awk '{print $1,$2}';
printf 'Platform: '; uname -m;
printf 'Time: '; date +'%H:%M:%S (%d/%m/%Y)';
printf 'Uptime: '; uptime | awk '{print $3,$4,$5}';
printf 'IP '; ifconfig eth0 | grep 'inet addr:' | awk '{print $2}';
printf 'Hostname: '; uname -n;
printf '\n********************\n';
printf 'SYSTEM USAGE:\n \n';
printf 'Load: '; uptime | awk '{print $10,$11,$12}';
printf 'Memory: '; free -m | grep 'cache:' | awk '{print $3,"mb used,",$4,"mb free"}'; 
printf 'Tasks: '; ps -A | wc -l;
printf '\n********************\n';
printf 'HARDWARE:\n \n';
printf 'CPU: '; cat /proc/cpuinfo | grep 'model name' | head -1;
printf 'Cores/Processors: '; cat /proc/cpuinfo | grep processor | tail -1 | awk '{print $3+1}';
printf 'RAM: '; free -m | grep Mem: | awk '{print $2,"mb"}';
printf '********************\n';
scrot -cd 5
