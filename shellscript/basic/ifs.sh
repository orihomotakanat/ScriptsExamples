#!/bin/bash

message='Hello World'

echo "No IFS setting"
for var in swift $message ruby java
do
  echo $var #Hello Worldの間にあるスペースがIFSの初期設定により、IFS変数に含まれる文字が単語の区切りとして認識されるため、HelloとWorldで改行される
done


echo "IFS setting"
_IFS=$IFS #IFS = InternalFieldSeparator(sp, ht or nl), IFSのばバックアップ(以降の他のコマンドにも影響を与えるため)
IFS=$'\n' #IFSを改行のみに設定する -> これで改行のみが単語の区切りとして認識される


for var in swift $message ruby java
do
  echo $var #Hello Worldが区切らず表示される
done

IFS=$_IFS #IFSを元に戻す
