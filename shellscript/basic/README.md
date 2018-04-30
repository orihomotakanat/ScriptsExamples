# Sample Shell result

## Basic shell
```basic.sh
$ ./basic.sh
The first PID which includes bash is  1043 ttys000    0:00.32 -bash
In the case of single quote, $PID is not shown
1799 is grep
grepshshshsh
```

## Paramters shell
```params.sh
$ ./params.sh a b c
Your specified all paramter are a b c
Your specified parameter is...
$1 = a, $2 = b and $3 = c

$ ./params.sh a b
Your specified all paramter are a b
Few paramters!! Please include just 3 paramters

$ ./params.sh a b c d
Your specified all paramter are a b c d
Too much paramters!! Please include  just 3 paramters

$ ./params.sh
All paramter are null. Please include parameters
```

### `if` condition memos
#### String
* `if [ str1 = str2 ]`: str1 = str2
* `if [ str1 != str2 ]`: str1 ≠ str2
* `if [ -n str ]`: str ≠ null
* `if [ -z str ]`: str = null

#### Int
* `if [ int1 -eq int2 ]`: int1 = int2
* `if [ int1 -ne int2 ]`: int1 ≠ int2
* `if [ int1 -lt int2 ]`: int1 < int2
* `if [ int1 -le int2 ]`: int1 <= int2
* `if [ int1 -gt int2 ]`: int1 > int2
* `if [ int1 -ge int2 ]`: int1 => int2

#### Evaluation of attributes
* `if [ -e file ]`: file exists
* `if [ -d file ]`: file exists and is directory
* `if [ -h (or L) file ]`: file exists and is symbolic-link
* `if [ -f file ]`: file exists and file is ordinary file
* `if [ -r file ]`: file exists and has permission to READ
* `if [ -w file ]`: file exists and has permission to WRITE
* `if [ -x file ]`: file exists and has permission to EXECUTE
* `if [ file1 -nt file2 ]`: Modified time - file1 = newer (file2 = older)
* `if [ file1 -ot file2 ]`: Modified time - file2 = newer (file1 = older)

#### Concatenation operator
* `if [ <condition1> -a <condition2> ]`: \<condition1\> = True AND \<condition2\> = True
* `if [ <condition1> -o <condition2> ]`: \<condition1\> OR \<condition2\> = True
* `!<condition>`: NOT
* `( )`: Grouping (ex.)`if [ -z str1 -a \(str2=Hello -o str3=World\) ]`
* `<CommandA> && <CommandB>`: Just only when \<CommandA\> is TRUE -> \<CommandB\>

(ex.)`$ [ -d "$dir" ] && cd $dir1`
* `<CommandA> || <CommandB>`: Just only when \<CommandA\> is FALSE -> \<CommandB\>

## Loop shell
```loop.sh
$ ./loop.sh java python cobol c
swift
ruby
shell
js
go
Hello world 1!!
Hello world 2!!
Hello world 3!!
Hello world 4!!
Hello world 5!!
Hello world 6!!
Hello world 7!!
Hello world 8!!
Hello world 9!!
java
python
cobol
c
2017
2017
1008
504
252
126
63
31
```

## Case shell
```
$ ./case.sh swift
My favorites

$ ./case.sh java
Want to study

$ ./case.sh python
I don't understand

$ ./case.sh
I don't understand
```

## Function shell
```func.sh
$ ./func.sh dynamoDB aurora redshift
Parameter check: OK
dynamoDB
aurora
redshift

$ ./func.sh dynamoDB
Paramter error
/func.sh: $ ./func.sh [param1] [param2] [param3]
Exit 1
```

### IFS shell
```ifs.sh
$ ./ifs.sh
No IFS setting
swift
Hello
World
ruby
java
IFS setting
swift
Hello World
ruby
java

$ echo -n "$IFS" | od -a
0000000   sp  ht  nl                                                    
0000003
```

### xargs results
```
$ ls | grep '.\.sh' | xargs cat | grep 'Hello'
message='Hello World'
  echo $var #Hello Worldの間にあるスペースがIFSの初期設定により、IFS変数に含まれる文字が単語の区切りとして認識されるため、HelloとWorldで改行される
  echo $var #Hello Worldが区切らず表示される
  echo "Hello world ${num}!!"
```
