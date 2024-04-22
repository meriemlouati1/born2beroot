#!/bin/bash
architecture=$(uname -a)
pcpu=$(lscpu | grep Socket | cut -d ':' -f 2 |tr -d ' ')
vcpu=$(lscpu | grep "^CPU(s)" | cut -d ':' -f 2 | tr -d ' ')
mu=$(inxi -m | sed -n '2p' | cut -d ' ' -f 8) 
mt=$(inxi -m | sed -n '2p' | cut -d ' ' -f 5)  
mp=$(inxi -m | sed -n '2p' | cut -d ' ' -f 10)
disku=$(inxi -d | sed -n '2p' | cut -d ' ' -f 9)
diskt=$(inxi -d | sed -n '2p' | cut -d ' ' -f 6)
diskp=$(inxi -d | sed -n '2p' | cut -d ' ' -f 11)
cpu=$(mpstat | tail -1 | tr -s ' ' | cut -d ' ' -f 13)
v=$(echo "scale=2; 100 - $cpu" | bc | xargs printf "%.2f")
date=$(who -b | tr -s ' ' | cut -d ' ' -f 4)
time=$(who -b | tr -s ' ' | cut -d ' ' -f 5)
lvm=$(lsblk | grep 'lvm')
if [ $? -eq 0 ]; then
	use="yes"
else
	use="non"
fi
ctcp=$(ss -ta | grep ESTAB |wc -l)
ulog=$(who | cut -d ' ' -f 1 | sort -u | wc -l)
ip=$(hostname -I)
mac=$(ip link | grep 'link/ether' | tr -s ' ' | cut -d ' ' -f 3)
nbsudo=$(grep -c 'COMMAND' /var/log/sudo/sudo.log)
wall "#Architecture : $architecture
#CPU PHYSICAL : $pcpu
#vCPU : $vcpu
#Memory Usage : $mu/$mt MB $mp
#Disk Usage : $disku/$diskt GB $diskp
#CPU load : $v%
#Last boot : $date $time
#LVM use : $use
#Connections TCP : $ctcp ESTABLISHED
#User log : $ulog 
#Network : IP $ip ($mac)
#Sudo : $nbsudo cmd"

