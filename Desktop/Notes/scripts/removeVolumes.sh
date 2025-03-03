#!/bin/bash
REGION="us-east-1"

volumes=$(aws ec2 describe-volumes --region $REGION --query "Volumes[*].VolumeId" --output text)

for volume in $volumes; 
do
    echo "deleting vol with vol Id:- ${volume}"
    aws ec2 delete-volume --region $REGION --volume-id $volume
done