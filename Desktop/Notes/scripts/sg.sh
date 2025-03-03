#!/bin/bash

# Define the tag key and value
TAG_KEY="kubernetes.io/cluster/ephemeral-6943654-1bc017bb"
TAG_VALUE="owned"

# List security groups with the specified tag
security_groups=$(aws ec2 describe-security-groups --filters "Name=tag:${TAG_KEY},Values=${TAG_VALUE}" --query "SecurityGroups[*].GroupId" --output text)

# Check if any security groups are found
if [ -z "$security_groups" ]; then
  echo "No security groups found with tag ${TAG_KEY}=${TAG_VALUE}"
else
  echo "Security groups with tag ${TAG_KEY}=${TAG_VALUE}:"
  echo "$security_groups"
  
  # Loop through each security group and delete it
  for sg_id in $security_groups; do
    echo "Deleting security group: $sg_id"
    aws ec2 delete-security-group --group-id $sg_id
    if [ $? -eq 0 ]; then
      echo "Successfully deleted security group: $sg_id"
    else
      echo "Failed to delete security group: $sg_id"
    fi
  done
fi
