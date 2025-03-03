#!/bin/bash
# Get a list of volume IDs based on the tag

TAG_KEY="ebs.csi.aws.com/cluster"
TAG_VALUE="true"
VOLUME_IDS=$(aws ec2 describe-volumes --filters Name=tag:$TAG_KEY,Values=$TAG_VALUE --query "Volumes[*].VolumeId" --output text)

if [ -z "$VOLUME_IDS" ]; then
    echo "No volumes found with tag $TAG_KEY=$TAG_VALUE"
    exit 0
fi

# Loop through each volume ID
for VOLUME_ID in $VOLUME_IDS; do
    echo "Processing volume: $VOLUME_ID"
    
    # Get a list of snapshot IDs for the volume
    SNAPSHOT_IDS=$(aws ec2 describe-snapshots --filters Name=volume-id,Values=$VOLUME_ID --query "Snapshots[*].SnapshotId" --output text)
    
    if [ -z "$SNAPSHOT_IDS" ]; then
        echo "  No snapshots found for volume $VOLUME_ID"
    else
        # Loop through each snapshot ID and delete the snapshot
        for SNAPSHOT_ID in $SNAPSHOT_IDS; do
            echo "  Deleting snapshot: $SNAPSHOT_ID"
            aws ec2 delete-snapshot --snapshot-id $SNAPSHOT_ID
        done
    fi
    
    # Delete the volume
    echo "  Deleting volume: $VOLUME_ID"
    aws ec2 delete-volume --volume-id $VOLUME_ID
done

echo "Cleanup complete."