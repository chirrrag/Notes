#!/bin/bash

# Ensure script exits on any error
set -e

# Variables for the tag key and value
TAG_KEY="cost-group"
TAG_VALUE="test-eks-v1"

# List all IAM roles
role_names=$(aws iam list-roles --query 'Roles[*].RoleName' --output text)

# Iterate over each role name
for role_name in $role_names; do
  # Get the tags for the current role
  tags=$(aws iam list-role-tags --role-name $role_name --query 'Tags')

  # Check if the role has the specified tag and value
  if echo "$tags" | jq -e ".[] | select(.Key == \"$TAG_KEY\" and .Value == \"$TAG_VALUE\")" > /dev/null; then
    echo "Processing role: $role_name"
    
    # Detach all managed policies from the role
    managed_policies=$(aws iam list-attached-role-policies --role-name $role_name --query 'AttachedPolicies[*].PolicyArn' --output text)
    for policy_arn in $managed_policies; do
      echo "Detaching managed policy $policy_arn from role $role_name"
      aws iam detach-role-policy --role-name $role_name --policy-arn $policy_arn
    done

    # Delete all inline policies from the role
    inline_policies=$(aws iam list-role-policies --role-name $role_name --query 'PolicyNames' --output text)
    for policy_name in $inline_policies; do
      echo "Deleting inline policy $policy_name from role $role_name"
      aws iam delete-role-policy --role-name $role_name --policy-name $policy_name
    done

    # Delete the role
    echo "Deleting role: $role_name"
    aws iam delete-role --role-name $role_name
  else
    echo "Skipping role: $role_name"
  fi
done

echo "Script completed."
