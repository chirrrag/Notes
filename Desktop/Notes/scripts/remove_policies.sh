#!/bin/bash

# Ensure script exits on any error
set -e

# Variables for the tag key and value
TAG_KEY="cost-group"
TAG_VALUE="aws-qa-4"

# Get a list of all customer managed policies ARNs
policy_arns=$(aws iam list-policies --scope Local --query 'Policies[*].Arn' --output text)

# Iterate over each policy ARN
for policy_arn in $policy_arns; do
  # Get the tags for the current policy
  tags=$(aws iam list-policy-tags --policy-arn $policy_arn --query 'Tags')

  # Check if the policy has the specified tag and value
  if echo "$tags" | jq -e ".[] | select(.Key == \"$TAG_KEY\" and .Value == \"$TAG_VALUE\")" > /dev/null; then
    echo "Processing policy: $policy_arn"
    
    # List all entities the policy is attached to
    attached_entities=$(aws iam list-entities-for-policy --policy-arn $policy_arn --output json)
    
    # Detach the policy from all users
    user_attachments=$(echo $attached_entities | jq -r '.PolicyUsers[].UserName')
    for user in $user_attachments; do
      echo "Detaching policy from user: $user"
      aws iam detach-user-policy --user-name $user --policy-arn $policy_arn
    done

    # Detach the policy from all groups
    group_attachments=$(echo $attached_entities | jq -r '.PolicyGroups[].GroupName')
    for group in $group_attachments; do
      echo "Detaching policy from group: $group"
      aws iam detach-group-policy --group-name $group --policy-arn $policy_arn
    done

    # Detach the policy from all roles
    role_attachments=$(echo $attached_entities | jq -r '.PolicyRoles[].RoleName')
    for role in $role_attachments; do
      echo "Detaching policy from role: $role"
      aws iam detach-role-policy --role-name $role --policy-arn $policy_arn
    done

    # Delete the policy
    echo "Deleting policy: $policy_arn"
    aws iam delete-policy --policy-arn $policy_arn --output json
  else
    echo "Skipping policy: $policy_arn"
  fi
done

echo "Script completed."
# # Get a list of all customer managed policies ARNs
# policy_arns=$(aws iam list-policies --scope Local --query 'Policies[*].Arn' --output text)

# # Iterate over each policy ARN
# for policy_arn in $policy_arns; do
#   # Get the tags for the current policy
#   tags=$(aws iam list-policy-tags --policy-arn $policy_arn --query 'Tags')

#   # Check if the policy has the specified tag and value
#   if echo "$tags" | jq -e ".[] | select(.Key == \"$TAG_KEY\" and .Value == \"$TAG_VALUE\")" > /dev/null; then
#     echo "Deleting policy: $policy_arn"
#     # Delete the policy
#     aws iam delete-policy --policy-arn $policy_arn
#   else
#     echo "Skipping policy: $policy_arn"
#   fi
# done

# echo "Script completed."
