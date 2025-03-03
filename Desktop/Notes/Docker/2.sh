#!/bin/bash

total_disk=$(df -h --total | grep 'total' | awk '{print $2}')

# echo $total_disk

total_mem=$(free -mh | grep 'Mem:' | awk '{print $2}')
# echo $total_mem

echo "---"
echo "Total disk: ${total_disk}T"
echo "Total memory: ${total_mem}MB"
echo "---"