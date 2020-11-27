#!/bin/bash

while getopts s:c:p: flag
do
    case "${flag}" in
        s) string=${OPTARG};;
        c) count=${OPTARG};;
        p) port=${OPTARG};;
    esac
done

BODY=''
NEWLINE=$'\\n'
i=1
while [[ $i -le $count ]]
do  
    if [[ $i -eq 1 ]] 
    then
        BODY=$BODY"<p>$string</p>"$NEWLINE
    elif [[ $i -eq $count ]]
    then
        BODY=$BODY"    <p>$string</p>"
    else
        BODY=$BODY"    <p>$string</p>"$NEWLINE
    fi
    ((i = i + 1))
    
done

sed -i -e 's#{BODY_PLACEHOLDER}#'"$BODY"'#' index.html

docker build -t web .
docker run -p $port:80 -d web

curl localhost:$port


