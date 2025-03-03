#!/bin/bash

# Fetch the raw log data
varOcg=$(curl -s "http://coderbyte.com/api/challenges/logs/web-logs-raw")

# Set the filter string
varFiltersCg="codebyte heroku/router"

# Loop through each line of the log data
while IFS= read -r line; do
  # Check if the line contains the filter string
  if [[ "$line" == *"$varFiltersCg"* ]]; then
    # Extract request_id
    request_id=$(echo "$line" | grep -oP 'request_id=\K[^ ]+')

    # Extract fwd value
    fwd=$(echo "$line" | grep -oP 'fwd=\K[^ ]+')

    # Check if fwd is MASKED
    if [[ "$fwd" == "MASKED" ]]; then
      echo "$request_id [M]"
    else
      echo "$request_id [$fwd]"
    fi
  fi
done <<< "$varOcg" # __define-ocg__ This variable contains the raw output logs.