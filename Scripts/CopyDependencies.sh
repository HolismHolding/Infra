#!/bin/bash

function CopyDependencies() {    
    echo "Copying dependencies ...";
    if [ ! -f "$PWD/Dependencies" ]; then
        return;
    fi
    input="$PWD/Dependencies"
    while IFS= read -r line || [ -n "$line" ]
        do
            Org=$(echo $line | cut -d'/' -f1)
            if [ ! -d "/Build/$Org" ]; then
                mkdir /Build/$Org
            fi
            echo "Copying /$line";
            cp -r /$line /Build/$line
        done < "$input"
}