#!/bin/bash

bucketName=casetest-samplebucket-user-a
aws s3api list-objects --bucket $bucketName | grep 'sample'| awk -F\" '{print $4}'| while read line #1
do
  echo $line
  aws s3api put-object-tagging --bucket $bucketName  --key $line --tagging 'TagSet=[{Key=dataFormat,Value=text}]' #2
  aws s3api get-object-tagging --bucket $bucketName  --key $line #3
done
