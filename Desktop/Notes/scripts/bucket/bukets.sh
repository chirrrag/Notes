#!/bin/bash

TAG_KEY="Name"
TAG_VALUE="Name"

buckets=$(aws s3api list-buckets --query "Buckets[].Name" --output text)

# loop through buckets and get its tags
for bucket in ${buckets}; do
    echo "bucket is: $bucket"
    tags=$(aws s3api get-bucket-tagging --bucket "$bucket" --query "TagSet" --output json 2>/dev/null)
    echo ${tags}
    # check if buckets has specific tags

    if echo "$tags" | jq -e ".[] | select(.Key == \"$TAG_KEY\" and .Value == \"$TAG_VALUE\")" >/dev/null; then
        echo "Bucket: $bucket has the tag $TAG_KEY=$TAG_VALUE"

        # Remove versioning from the bucket
        aws s3api put-bucket-versioning --bucket "$bucket" --versioning-configuration Status=Suspended
        echo "Versioning suspended for bucket: $bucket"

        # Delete all object versions
        versions=$(aws s3api list-object-versions --bucket "$bucket" --query "Versions[].{Key:Key,VersionId:VersionId}" --output json)
        markers=$(aws s3api list-object-versions --bucket "$bucket" --query "DeleteMarkers[].{Key:Key,VersionId:VersionId}" --output json)

        echo $versions
        echo $markers

        if [ "$versions" != "null" ]; then
            for row in $(echo "${versions}" | jq -r '.[] | @base64'); do
                _jq() {
                    echo ${row} | base64 --decode | jq -r ${1}
                }
                aws s3api delete-object --bucket "$bucket" --key "$(_jq '.Key')" --version-id "$(_jq '.VersionId')"
                echo "Deleted version: $(_jq '.Key') (VersionId: $(_jq '.VersionId'))"
            done
        else
            echo "No versions found in bucket: $bucket"
        fi

        if [ "$markers" != "null" ]; then
            for row in $(echo "${markers}" | jq -r '.[] | @base64'); do
                _jq() {
                    echo ${row} | base64 --decode | jq -r ${1}
                }
                aws s3api delete-object --bucket "$bucket" --key "$(_jq '.Key')" --version-id "$(_jq '.VersionId')"
                echo "Deleted marker: $(_jq '.Key') (VersionId: $(_jq '.VersionId'))"
            done
        else
            echo "No delete markers found in bucket: $bucket"
        fi

        # Delete all objects in the bucket
        objects=$(aws s3api list-objects --bucket "$bucket" --query "Contents[].{Key:Key}" --output json)
        if [ "$objects" != "null" ]; then
            for row in $(echo "${objects}" | jq -r '.[] | @base64'); do
                _jq() {
                    echo ${row} | base64 --decode | jq -r ${1}
                }
                aws s3api delete-object --bucket "$bucket" --key "$(_jq '.Key')"
                echo "Deleted object: $(_jq '.Key')"
            done
        else
            echo "No objects found in bucket: $bucket"
        fi

        # Delete the bucket
        aws s3api delete-bucket --bucket "$bucket"
        echo "Deleted bucket: $bucket"
    fi
done
