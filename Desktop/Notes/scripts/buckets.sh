#!/bin/bash

TAG_KEY=""
TAG_VALUE=""

buckets=$(aws s3api list-buckets --query "Buckets[].Name" --output text)

# loop through buckets and get its tags

for bucket in $buckets;
do
    tags=$(aws s3api get-bucket-tagging --bucket "$bucket" --query "TagSet" --output json 2>/dev/null)

    # check if buckets has specific tags
    if echo "$tags" | grep -q "\"Key\": \"$TAG_KEY\", \"Value\": \"$TAG_VALUE\""; 
    then    
        echo "Bucket: ${bucket} has the tag $TAG_KEY=$TAG_VALUE"
        echo "deleting $bucket bucket"
        
        echo "removing versioning"
        aws s3api put-bucket-versioning --bucket "$bucket" --versioning-configuration Status=Suspended
        echo "versioning suspended for bucket $bucket"

        # Delete all object versions
        versions=$(aws s3api list-object-versions --bucket "$bucket" --query "Versions[].{Key:Key,VersionId:VersionId}" --output json)
        markers=$(aws s3api list-object-versions --bucket "$bucket" --query "DeleteMarkers[].{Key:Key,VersionId:VersionId}" --output json)

        for row in $(echo "${versions}" | jq -r '.[] | @base64'); do
            _jq() {
                echo ${row} | base64 --decode | jq -r ${1}
            }
            aws s3api delete-object --bucket "$bucket" --key "$(_jq '.Key')" --version-id "$(_jq '.VersionId')"
            echo "Deleted version: $(_jq '.Key') (VersionId: $(_jq '.VersionId'))"
        done

        for row in $(echo "${markers}" | jq -r '.[] | @base64'); do
            _jq() {
                echo ${row} | base64 --decode | jq -r ${1}
            }
            aws s3api delete-object --bucket "$bucket" --key "$(_jq '.Key')" --version-id "$(_jq '.VersionId')"
            echo "Deleted marker: $(_jq '.Key') (VersionId: $(_jq '.VersionId'))"
        done

        # Delete all objects in the bucket
        objects=$(aws s3api list-objects --bucket "$bucket" --query "Contents[].{Key:Key}" --output json)
        for row in $(echo "${objects}" | jq -r '.[] | @base64'); do
            _jq() {
                echo ${row} | base64 --decode | jq -r ${1}
            }
            aws s3api delete-object --bucket "$bucket" --key "$(_jq '.Key')"
            echo "Deleted object: $(_jq '.Key')"
        done

        # Delete the bucket
        aws s3api delete-bucket --bucket "$bucket"
        echo "Deleted bucket: $bucket"


    fi 
done


