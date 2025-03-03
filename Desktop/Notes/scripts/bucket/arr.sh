#!/bin/bash

arr=("abc","def")

arr+=('gef')

echo ${arr[*]}