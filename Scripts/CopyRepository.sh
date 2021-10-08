#!/bin/bash

function CopyRepository() {
    echo "Copying repository ...";
    if [ -d "/Build/$Organization/$Repository" ]; then
        sudo rm -rf /Build/$Organization/$Repository
    fi
    mkdir -p /Build/$Organization/$Repository
    cp -r /$Organization/$Repository /Build/$Organization/
}

# function CopyRepository() {
#     echo "Copying repository ..."
#     Org=$(echo $PWD | cut -d'/' -f2)
#     if [ ! -d "/Build/$Org" ]; then
#         mkdir /Build/$Org
#     fi
#     cp -r $PWD /Build$PWD
# }