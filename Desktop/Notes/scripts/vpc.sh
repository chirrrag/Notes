#!/bin/bash

### For vpc and subnets
tag_name="slb.com/cluster"
tag_value=${cluster_id}
REGION="us-east-1"

### For Security-group tag
tag_for_sg="kubernetes.io/cluster/ephemeral-6929611"
tag_value_sg="Owned"

#Retrieve ID's
vpc_id=$(aws ec2 describe-vpcs --region ${REGION} --filters "Name=tag:${tag_name},Values=${tag_value}" --query "Vpcs[0].VpcId" --output text)
subnet_ids=$(aws ec2 describe-subnets --region ${REGION} --filters "Name=tag:${tag_name},Values=${tag_value}" --query  "Subnets[*].SubnetId" --output text)
security_group_ids=$(aws ec2 describe-security-groups --region ${REGION} --filters "Name=tag:${tag_for_sg},Values=${tag_value_sg}" --query "SecurityGroupIds[*].groupId" --output text)
igw_id=$(aws ec2 describe-internet-gateways --region ${REGION} --filters "Name=tag:${tag_name},Values=${tag_value}" --query 'InternetGateways[*].InternetGatewayId' --output text)

### Delete subnets
for subnet_id in $subnet_ids; do
  aws ec2 delete-subnet --region ${REGION} --subnet-id $subnet_id 
done

### Delete Sg's
for security_group_id in $security_group_ids; do
  aws ec2 delete-security-group --region ${REGION} --group-id $security_group_id
done

###Delete IGW and VPC
aws ec2 detach-internet-gateway --region ${REGION} --internet-gateway-id ${igw_id} --vpc-id ${vpc_id}
aws ec2 delete-internet-gateway --region ${REGION} --internet-gateway-id ${igw_id}
aws ec2 delete-vpc --region ${REGION} --vpc-id "$vpc_id"
