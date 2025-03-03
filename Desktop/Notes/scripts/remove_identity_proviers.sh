#!/bin/bash

# Ensure script exits on any error
set -e

# Variables for the tag key and value
TAG_KEY="cost-group"
TAG_VALUE="test-eks-v1"

# Get a list of all IAM OIDC identity providers ARNs
oidc_providers=$(aws iam list-open-id-connect-providers --query 'OpenIDConnectProviderList[*].Arn' --output text)

# Iterate over each OIDC provider ARN
for provider_arn in $oidc_providers; do
  # Get the tags for the current OIDC provider
  tags=$(aws iam list-open-id-connect-provider-tags --open-id-connect-provider-arn $provider_arn --query 'Tags')

  # Check if the OIDC provider has the specified tag and value
  if echo "$tags" | jq -e ".[] | select(.Key == \"$TAG_KEY\" and .Value == \"$TAG_VALUE\")" > /dev/null; then
    echo "Deleting OIDC provider: $provider_arn"
    # Delete the OIDC provider
    aws iam delete-open-id-connect-provider --open-id-connect-provider-arn $provider_arn
  else
    echo "Skipping OIDC provider: $provider_arn"
  fi
done

echo "Script completed."
