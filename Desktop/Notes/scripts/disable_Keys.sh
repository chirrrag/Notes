#!/bin/bash

key_ids=$(aws kms list-keys --query 'Keys[*].KeyId' --output text)
echo $key_ids

for key in $key_ids; do
# aws kms describe-key --key-id 5f5739cb-5428-4e28-924f-137c8ae9120f --query 'KeyMetadata.KeyManager' --output text
    key_metadata=$(aws kms describe-key --key-id $key --query 'KeyMetadata.KeyManager' --output text)
    if [ "$key_metadata" == "CUSTOMER" ]; then
        echo "Processing key: $key"

        aws kms disable-key --key-id $key
        
        aws kms schedule-key-deletion --key-id $key --pending-window-in-days 7
    else 
        echo "skipping aws managed keys: $key"
    fi
done

