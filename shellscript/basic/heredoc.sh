#!/bin/bash

function showUsage ()
{
  local scriptName=$(basename "$0") #local = local variable

  #Heredoc
  cat << END #<Command> << <Fin>
HowToUse: $scriptName [Params1] [Params2]
Output [Params1]&[Params2] on console

  [Params1]     Word, Number, etc...
  [Params2]     Word, Number, etc...

Examples:
  $scriptName Hello World
END #<Fin>
}


if [ "$#" -eq 0 ]; then
  showUsage
  exit 1
else
  echo "$@"
fi
