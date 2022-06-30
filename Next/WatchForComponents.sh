#!/bin/bash

function RefreshLink()
{
    ModifiedFile=$1
    find /$Organization/$Repository/ -type l | grep -v node_modules | grep -v .gitignore |
    while read LinkedFile; do 
        OriginalPath=$(readlink -f $LinkedFile)
        if [[ $OriginalPath == $ModifiedFile ]]; then
            Temp=$(dirname $ModifiedFile)/wjagCcKD0uY859DianqQ.temp

            echo "Modified file: $ModifiedFile"
            echo "Linked file: $LinkedFile"
            echo "Original path: $OriginalPath"
            echo "Temp: $Temp"
            cp $ModifiedFile $Temp
            ln -s -f $Temp $LinkedFile
            sleep 0.01
            ln -s -f $ModifiedFile $LinkedFile
            rm -rf $Temp
        fi
    done
}

inotifywait -m /HolismReact/ -r -e modify --format '%w%f' "$1" | 
while read ModifiedFile
do
    RefreshLink $ModifiedFile
done