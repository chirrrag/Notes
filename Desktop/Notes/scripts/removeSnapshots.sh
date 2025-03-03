#!/bin/bash
snapshots=$(aws ec2 describe-snapshots --owner-ids self --query "Snapshots[*].[SnapshotId]" --region "us-east-1" --output text)

# echo $snapshots

for snapshot in $snapshots
do
    echo $snapshot
    aws ec2 delete-snapshot --region "us-east-1" --snapshot-id $snapshot 
done