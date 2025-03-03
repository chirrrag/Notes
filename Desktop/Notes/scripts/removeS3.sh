#!/bin/bash

BUCKET_NAME="tfstate-lightops-us-east-1-891377400965"
PREFIX="eks/ephemeral-6846889-199236c4/"

markers=$(aws s3api list-object-versions --bucket "${BUCKET_NAME}" --prefix "${PREFIX}" --no-paginate --output json --query "{Objects: DeleteMarkers[].{Key:Key,VersionId:VersionId}}")
echo "markers:- ${markers}"
while [[ $(echo "${markers}" | jq '.Objects | length') -ne 0 ]]
do
    aws s3api delete-objects --no-paginate --no-cli-pager --bucket "${BUCKET_NAME}" --delete "${markers}"
    markers=$(aws s3api list-object-versions --bucket "${BUCKET_NAME}" --no-paginate --query='{Objects: DeleteMarkers[].{Key:Key,VersionId:VersionId}}')
    echo "Removed $(echo "${markers}" | jq '.Objects | length') delete markers"
done

# removing objects and all their versions
echo "object and versions"
ObjectsandVersion=$(aws s3api list-object-versions --bucket "${BUCKET_NAME}" --prefix "${PREFIX}" --no-paginate --output json --query="{Objects: Versions[].{Key:Key,VersionId:VersionId}}")
# disable versioning on object
echo "disable s3 bucket"
aws s3api put-bucket-versioning --bucket "${BUCKET_NAME}" --versioning-configuration Status=Suspended
echo "print object and versions"
echo "${ObjectsandVersion}"

while [[ $(echo "${ObjectsandVersion}" | jq '.Objects | length') -ne 0 ]]
do
    aws s3api delete-objects --no-paginate --no-cli-pager --bucket "${BUCKET_NAME}" --delete "${ObjectsandVersion}"
    
    ObjectsandVersion=$(aws s3api list-object-versions --bucket "${BUCKET_NAME}" --prefix "${PREFIX}" --no-paginate --query='{Objects: Versions[].{Key:Key,VersionId:VersionId}}')
    
    echo "Removed $(echo "${ObjectsandVersion}" | jq '.Objects | length') objects"

    
done