#!/bin/bash

# Define the tag key and value to filter buckets
TAG_KEY="YourTagKey"
TAG_VALUE="YourTagValue"

# Get a list of all buckets with names starting with "crossplane-"
BUCKETS=$(aws s3api list-buckets --query "Buckets[?starts_with(Name, 'crossplane-')].Name" --output text)

# Loop through each bucket
for BUCKET in $BUCKETS; do
    echo "Processing bucket: $BUCKET"

    # Get the tags for the bucket
    TAGS=$(aws s3api get-bucket-tagging --bucket $BUCKET 2>/dev/null)

    # Check if the bucket has the specific tag
    if echo $TAGS | grep -q "\"Key\": \"$TAG_KEY\""; then
        if echo $TAGS | grep -q "\"Value\": \"$TAG_VALUE\""; then
            echo "Bucket $BUCKET has the tag $TAG_KEY:$TAG_VALUE"

            # Remove all object versions
            VERSIONS=$(aws s3api list-object-versions --bucket $BUCKET --query 'Versions[].{Key:Key,VersionId:VersionId}' --output text)
            DELETEMARKERS=$(aws s3api list-object-versions --bucket $BUCKET --query 'DeleteMarkers[].{Key:Key,VersionId:VersionId}' --output text)

            # Delete all object versions
            for VERSION in $VERSIONS; do
                KEY=$(echo $VERSION | awk '{print $1}')
                VERSION_ID=$(echo $VERSION | awk '{print $2}')
                aws s3api delete-object --bucket $BUCKET --key "$KEY" --version-id "$VERSION_ID"
            done

            # Delete all delete markers
            for DELETEMARKER in $DELETEMARKERS; do
                KEY=$(echo $DELETEMARKER | awk '{print $1}')
                VERSION_ID=$(echo $DELETEMARKER | awk '{print $2}')
                aws s3api delete-object --bucket $BUCKET --key "$KEY" --version-id "$VERSION_ID"
            done

            # Delete the bucket
            aws s3api delete-bucket --bucket $BUCKET
            echo "Bucket $BUCKET deleted"
        else
            echo "Bucket $BUCKET does not have the tag value $TAG_VALUE"
        fi
    else
        echo "Bucket $BUCKET does not have the tag key $TAG_KEY"
    fi
done
