#!/bin/bash

# Set the AWS region
REGION="us-east-1"

# Get a list of all EBS volumes in the specified region
VOLUME_IDS=$(aws ec2 describe-volumes --region $REGION --query "Volumes[*].VolumeId" --output text)

# Iterate over each volume ID and delete the volume
for VOLUME_ID in $VOLUME_IDS; do
    echo "Deleting volume $VOLUME_ID"
    aws ec2 delete-volume --volume-id $VOLUME_ID --region $REGION
done

echo "All EBS volumes have been deleted."
