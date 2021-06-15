#!/bin/zsh

id=127.0.0.1

i=1
while [ $i -le 5 ]
do
    ping -c1 $id &>/dev/null
    if [ $? -eq 0 ]; then
        echo "$id is up."
    fi
    i=$[i+1]
done