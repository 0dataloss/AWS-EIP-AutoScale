#!/bin/bash

# This script will make sure all the EIP which were assigned to an instance ( instance:yes )will go back
# to be tagged with instance:not

for i in $(aws ec2 describe-addresses --filters "Name=tag:instance,Values='yes'"  | grep  '"PublicIp"' | cut -d\" -f 4) ; do
  aws ec2 describe-addresses --public-ip $i --filters "Name=association-id,Values='*'" | grep "AssociationId"
  if [ $? -eq 1 ]; then
    EIPALLOC=$(aws ec2 describe-addresses --region eu-west-1 --filters "Name=public-ip,Values=$i" | grep 'AllocationId' | cut -d\" -f 4) &&  aws ec2 create-tags --region eu-west-1 --resources $EIPALLOC --tags Key=instance,Value="not"
  fi
done
