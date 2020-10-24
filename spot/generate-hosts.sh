#!/bin/bash

rm -f /tmp/hosts

for i in *.json ; do
COMPONENT=$(echo $i | sed -e 's/.json//')
echo "[$COMPONENT]" >>/tmp/hosts
aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}" --query 'Reservations[*].Instances[*],PrivateIpAddress' --output text >>/tmp/hosts
done
