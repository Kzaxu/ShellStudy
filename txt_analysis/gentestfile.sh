#!/bin/zsh

filePath="/Users/xuxu/WorkSpace/Bash/BashStudy/txt_analysis/logFile.txt"
logNum=100
command="date \"+%y-%m-%d %H:%M%S\""
wordArry=(hello hi you me my today sum haha 1223412 ssss tt sunday)
upperRange=${#wordArry[*]}
length=10


if (($#==1)); then
    filePath=$1
    echo "default gen 100 logs"
elif (($#==0)); then
    echo "use default log path"
else
    filePath=$1
    logNum=$2
fi

for i in `seq 1 $logNum`
do
    time_str=`eval $command`
    curLine=""
    for i in `seq 1 10`
    do
        curWord="${wordArry[`jot -r 1 1 $upperRange`]}"; 
        curLine="$curLine $curWord"
    done
    curLine="$time_str $curLine"
    echo $curLine >> $filePath
done

