#!/bin/bash

for iter in {1..10}
do
    # create files with sequential names
    touch "file-${iter}.txt"
done
