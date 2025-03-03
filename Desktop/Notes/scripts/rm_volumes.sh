#!/bin/bash

# Variables
TAG_KEY="kubernetes.io/cluster/ephemeral-7053920-296f00ff"
TAG_VALUE="owned"

# Fetch volume IDs with the specified tag key and value
volume_ids=$(aws ec2 describe-volumes --filters "Name=tag:${TAG_KEY},Values=${TAG_VALUE}" --query "Volumes[*].VolumeId" --output text)

# Check if any volumes were found
if [ -z "$volume_ids" ]; then
  echo "No volumes found with tag ${TAG_KEY}=${TAG_VALUE}"
else
  # Loop through each volume ID and delete it
  for volume_id in $volume_ids; do
    echo "Deleting volume: $volume_id"
    aws ec2 delete-volume --volume-id $volume_id
  done
  echo "Deletion process complete."
fi
