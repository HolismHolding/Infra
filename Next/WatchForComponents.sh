#!/bin/bash

function SetJsConfig()
{
    ModifiedFile=$1
}

function SetExports()
{
    ModifiedFile=$1
}

inotifywait -m /$RepositoryPath/components -r --format '%w%f' "$1" | 
while read ModifiedFile
do
    SetJsConfig $ModifiedFile
    SetExports $ModifiedFile
done