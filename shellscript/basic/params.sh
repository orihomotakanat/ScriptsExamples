#!/bin/bash

if [ -z "$1" -a -z "$2" -a -z "$3" ]; then #$1かつ$2かつ$3がnullでない時. $@で指定できない
  echo "All paramter are null. Please include parameters"
  exit 1
else
  echo "Your specified all paramter are $@" # $ ./params.sh($0) $1 $2... (全ては$@ or $*)
fi


if [ "$#" -lt 3 ]; then #paramters < 3
  echo "Few paramters!! Please include just 3 paramters"
elif [ "$#" -ge 4 ]; then #parameters >= 4
  echo "Too much paramters!! Please include  just 3 paramters"
else # paramters = 3
  echo "Your specified parameter is..." #自動で改行入る
  echo "\$1 = $1, \$2 = $2 and \$3 = $3"
fi
