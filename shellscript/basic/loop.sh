#!/bin/bash

for var in swift ruby shell js go
do
  echo $var
done

for num in $(seq 1 9)
do
  echo "Hello world ${num}!!"
done

if [ -z "$1" ]; then
  echo "Please include paramters"
  exit 1
else
  for params in "$@"
  do
    echo $params #"$params"でも良い
  done
fi

thisYear=2017
echo $thisYear
while [ "$thisYear" -ge 30 ]
do
  echo "$thisYear"
  thisYear=$((thisYear / 2)) #$(( ))はbash特有の算術展開
done
