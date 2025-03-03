#!/bin/bash



# print container name, which restart count is more than 0

while read -r line; do
    containerName=$(echo "$line" | awk '{print $1}')
    restartCount=$(echo "$line" | awk '{print $4}')
    # echo "$restartCount"
    if [ "$restartCount" -ge 1 ]; then
        echo "$containerName"
    fi
done < txt.txt
