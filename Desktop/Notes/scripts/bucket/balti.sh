#!/bin/bash

TAG_KEY="crossplane-kind"
TAG_VALUE="bucket.s3.aws.upbound.io"

# get bucket arn
# bucket_arn=$(aws resourcegroupstaggingapi get-resources --resource-type-filters s3:bucket --tag-filters Key=${TAG_KEY},Values=${TAG_VALUE} --no-paginate --query "ResourceTagMappingList[][].ResourceARN" --output json )
bucket_arn=$(aws resourcegroupstaggingapi get-resources --resource-type-filters s3:bucket --tag-filters Key=${TAG_KEY},Values=${TAG_VALUE} | jq -r '.ResourceTagMappingList[].ResourceARN')


echo $bucket_arn

# filter buckets and remove content

if [ -z "$bucket_arn" ]; then
    echo "No resources were found with tag Key: ${TAG_KEY} and Value: ${TAG_VALUE}"
else
    for bucket in $bucket_arn; do
        # arn=$bucket
        # bucketName=$(echo ${bucket} | cut -d ':' -f 6)
        bucket=$(echo ${bucket} | awk -F '[:/]' '{print $NF}')
        # bucketName=${bucketName%\"}

        echo "Bucket Name : ${bucket}"

        # bucket=$(echo ${bucket} | xargs)

        # suspend bucket versioning
        echo "suspending versioning"
        aws s3api put-bucket-versioning --bucket ${bucket} --versioning-configuration Status="Suspended" 
        echo "versioning suspended for ${bucket}"

        # deleting contents and object of bucket
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

        aws s3 rb s3://${bucket} --force

    done
fi




  
