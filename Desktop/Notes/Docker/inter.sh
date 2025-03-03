#!/bin/bash

ocg="Dockerfile"
filters="numpy scipy pandas"

# Create docker file
echo "FROM python:3" >> $ocg
echo "RUN pip install ${filters}" >> $ocg
echo "CMD [\"python\", \"./main.py\"]" >> $ocg

# output
echo "HASH_OUTPUT=$(sha1sum $ocg | awk '{print $1}')"

# print hash
echo "HASH_OUTPUT $hash_output Dockerfile"

echo $HASH_OUTPUT
