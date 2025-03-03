#!/bin/bash
Tag="kubernetes.io/cluster/ephemeral-6924480-1b4abe54"
Value="owned"
LoadBalancerArn=$(aws elb describe-load-balancers --output json | jq -r  '.[].[] | [.LoadBalancerName] | @csv' > lb.csv)
aws elb describe-load-balancers --query "LoadBalancerDescriptions[*].LoadBalancerName" --output json > lb.json
# echo ${LoadBalancerArn}

# aws elbv2 describe-load-balancers --query "LoadBalancers[*].Name" --output json

# LB=$(aws elb describe-load-balancers --output text)
# echo ${LB}
# --query "LoadBalancers[*].LoadBalancerArn"