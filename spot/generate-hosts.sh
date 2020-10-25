#!/bin/bash

rm -f /tmp/hosts

for i in *.json ; do
  COMPONENT=$(echo $i | sed -e 's/.json//')
  IP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}" --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text)
  if [ -z "${IP}" ]; then
    continue
  fi
  echo $IP component=$COMPONENT >>/tmp/hosts