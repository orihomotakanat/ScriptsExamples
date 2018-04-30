#!/bin/bash

array=(20171001-20171101/ 20171101-20171201/ 20171201-20180101/ 20180101-20180201/ 20180201-20180301/ 20180301-20180401/)
manifest="<name>-Manifest.json"

for key in ${array[@]}
do
  # echo $key
  aws s3 ls s3://<your-bucket>/${key} | awk '{print $NF}' | while read file
  do
    # echo $file
    if [ $file = $manifest ]; then
      echo -e "\n>>>>>>>>>>FOUND!!<<<<<<<<<<<<<<"
      aws s3 rm s3://<your-bucket>/${key}${manifest}
    else
      echo -e "\n---------------Not found. Plese wait dig next path...---------------"
      aws s3 ls s3://<your-bucket>/${key}${file} | awk '{print $NF}' | while read nextfile
      do
        # echo $file
        if [ $nextfile = $manifest ]; then
          echo -e "\n>>>>>>>>>>FOUND!!<<<<<<<<<<<<<<"
          aws s3 rm s3://<your-bucket>/${key}${file}${manifest}
        else
          echo -e "\n---------------Not found. No manifest file---------------"
        fi
      done
    fi
  done
done
