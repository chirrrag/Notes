#!/bin/bash 
TAG_KEY="kubernetes.io/cluster/np-t-sdfc-26119-dev-aws-ephemeral-csap"
TAG_VALUE="owned"
AWS_REGION="us-east-1"

volumeList=$(aws ec2 describe-volumes --output json --query "Volumes[?Tags[?Key=='$TAG_KEY' && Value=='$TAG_VALUE']]")
echo "${volumeList}"
if [[ -n "${volumeList}" ]]; then
    echo "Deleting volumes with the tag '${TAG_KEY} = ${TAG_VALUE}'"
    # echo "${volumeList}"

    # Iterate over the volume IDs and delete them
    for volumeId in $(echo "${volumeList}" | jq -r '.[] | .VolumeId'); do
        echo "volume id:- ${volumeId}"
        aws ec2 delete-volume --volume-id ${volumeId} --region ${AWS_REGION} 
    done
else
    echo "Volumes with the tag '${TAG_KEY} = ${TAG_VALUE}' were not found"
fi