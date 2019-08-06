#!/bin/bash
# Replace eipalloc-xxxxxxxxxx eipalloc-yyyyyyyyyyyy eipalloc-zzzzzzzzzzz with all the
# EIP allocation-id you want to tag to be part of this platform

for i in eipalloc-xxxxxxxxxx eipalloc-yyyyyyyyyyyy eipalloc-zzzzzzzzzzz; do
  aws ec2 create-tags --region eu-west-1 --resources $i --tags Key=instance,Value="not"
done
