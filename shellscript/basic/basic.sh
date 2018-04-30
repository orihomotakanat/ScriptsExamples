#!/bin/bash

PID=$(ps -x | grep bash | head -1) #$( )コマンド置換
echo "The first PID which includes bash is $PID"
echo 'In the case of single quote, $PID is not shown' #singleQuoteの場合は表示されない

Proc=$(ps -x | grep bash | tail -1 | awk '{print $4}')
echo "`ps -x | grep bash | tail -1 | awk '{print $1}'` is $Proc" #バッククォートで埋め込める。$( )と同様
echo ${Proc}shshshsh #${ }で変数名の区切り明示
