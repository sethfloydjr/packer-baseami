#!/bin/bash -x
aws ec2 modify-image-attribute --image-id $AMI_ID --launch-permission "{\"Add\": [{\"UserId\":\"$AWS_SECOND_ACCOUNT\"}]}" --region $AWS_REGION
