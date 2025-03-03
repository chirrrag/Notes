#!/bin/bash

# Ensure AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI could not be found. Please install it and configure your credentials."
    exit 1
fi

# Get all volume IDs
volume_ids=$(aws ec2 describe-volumes --query "Volumes[*].VolumeId" --output text)

# Check if there are any volumes
if [ -z "$volume_ids" ]; then
    echo "No EBS volumes found."
    exit 0
fi

# Loop through each volume ID and list its tags
for volume_id in $volume_ids; do
    echo "Tags for volume ID: $volume_id"
    aws ec2 describe-tags --filters "Name=resource-id,Values=$volume_id" --query "Tags[*].[Key,Value]" --output table
    echo ""
done
