#!/bin/bash
TAG_KEY="kubernetes.io/cluster/ephemeral-6924480-1b4abe54"
TAG_VALUE="owned"

load_balancers=$(aws elb describe-load-balancers --query "LoadBalancerDescriptions[*].LoadBalancerName" --output text)
# Loop through each load balancer and check its tags
for lb in $load_balancers; do
  # Get the tags for the current load balancer
  tags=$(aws elb describe-tags --load-balancer-names $lb --query "TagDescriptions[*].Tags[?Key=='$TAG_KEY' && Value=='$TAG_VALUE']" --output text)
  # Check if the tags match the specified key and value
  if [ -n "$tags" ]; then
    echo $tags
    echo "Load Balancer: $lb"
    aws elb delete-load-balancer --load-balancer-name $lb
  fi
done