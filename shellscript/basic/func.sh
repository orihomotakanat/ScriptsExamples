#!/bin/bash

function paramChecker () #function <funcName> or <funcName> () でもOK
{
  if [ "$#" -eq 3 ]; then
    echo "Parameter check: OK"
  else
    echo "Paramter error"
    echo "/func.sh: $ ./func.sh [param1] [param2] [param3]"
    return 1 #StatusCode
  fi
}

paramChecker "$@" #parameter functionにparamsを渡す

exitCode=$?
if [ "$exitCode" -eq 1 ]; then #return 1ならexit
  echo "Exit $exitCode"
  exit $exitCode
fi

for param in "$@"
do
  echo "$param"
done
