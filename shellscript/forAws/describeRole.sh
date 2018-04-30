#!/bin/bash

outputfile=roleProfile.txt #outputfile

# EC2
echo -e "*********EC2*********" >> $outputfile
aws ec2 describe-regions | jq -r '.Regions[].RegionName' | while read region  #If you want to filter the region, please run (ex.) aws ec2 describe-regions --filters "Name=endpoint,Values=*us*". Please refer to http://docs.aws.amazon.com/cli/latest/reference/ec2/describe-regions.html
do
  echo "Checking EC2 ${region}..."
  echo -e "\n =========${region}=========">> $outputfile
  aws ec2 describe-instances --region $region | jq '.Reservations[].Instances[] | { InstanceId: .InstanceId, IAMRole: .IamInstanceProfile.Arn}' >> $outputfile
done
echo -e "---------Finish---------\n" >> $outputfile


# Lambda
echo -e "*********Lambda function*********" >> $outputfile
aws ec2 describe-regions | jq -r '.Regions[].RegionName' | while read region
do
  echo "Checking Lambda ${region}..."
  echo -e "\n =========${region}=========">> $outputfile
  aws lambda list-functions --region $region | jq '.Functions[] | { Function: .FunctionName, Role: .Role}' >> $outputfile
done

echo -e "---------Finish---------\n" >> $outputfile
