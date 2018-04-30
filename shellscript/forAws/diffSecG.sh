#!/bin/bash

sgList='sglist.txt'

aws ec2 describe-instances --query Reservations[].Instances[].SecurityGroups[].GroupId | grep 'sg' | awk -F\" '{print $2}' | while read line
do
  echo $line >> $sgList
done

cat $sgList | sort -u
rm $sgList
