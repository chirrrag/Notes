#!/bin/bash

kubectl api-resources --namespaced=false -oname | grep -vE '(providerconfig|storeconfig)' | grep 'aws.upbound.io' | while IFS= read -r api_resource ; do
  echo "Found $api_resource api resource, processing.."
  kubectl get $api_resource -oname | xargs -IF kubectl delete F --wait=false
done