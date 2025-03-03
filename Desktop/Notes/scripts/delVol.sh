#!/bin/bash
for volume_id in $(aws ec2 describe-volumes --filters Name=status,Values=available --query "Volumes[*].VolumeId" --output text); do
  aws ec2 delete-volume --volume-id $volume_id
  echo "Deleted volume: $volume_id"
done