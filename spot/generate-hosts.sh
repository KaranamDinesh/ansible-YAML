#!/bin/bash
sudo rm -f /tmp/hosts
for i in *.json ;
do
  COMPONENT=$(echo $i | sed -e 's/.json//')
  IP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}" --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text)
  echo $IP component=$COMPONENT >>/tmp/hosts
  sed -e "s/IPADDRESS/${IP}/" -e "s/DNS_NAME/${COMPONENT}/" record > /tmp/record.json

  aws route53 change-resource-record-sets --hosted-zone-id Z07205463ID26P25SSK4I
   --change-batch file:///tmp/record.json
done