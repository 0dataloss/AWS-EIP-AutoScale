#!/bin/bash

# This script will have to be executed by the User Data in Autoscaling Group
# Will automatically assign one IP address from a pool of EIP tagged with key:instance and value:not to a linux EC2 instance
# Will replace key:instance and value:not with key:instance and value:yes

INSTANCEID=$(/usr/bin/curl -s http://169.254.169.254/latest/meta-data/instance-id)

IPADDRESS=$(aws ec2 --region eu-west-1 describe-addresses --filters "Name=tag:instance,Values=not" | grep '"PublicIp"' | tail -n1 | cut -d\" -f 4)

EIPALLOC=$(aws ec2 describe-addresses --region eu-west-1 --filters "Name=public-ip,Values=$IPADDRESS" | grep 'AllocationId' | cut -d\" -f 4)

aws ec2 associate-address --region eu-west-1 --instance-id $INSTANCEID  --allocation-id $EIPALLOC

EIPALLOCGOT=$(aws ec2 describe-addresses --region eu-west-1 --filter "Name=instance-id,Values=${INSTANCEID}" | grep 'AllocationId' | cut -d\" -f 4)

aws ec2 delete-tags --region eu-west-1 --resources $EIPALLOCGOT --tags Key=instance,Value="not"
