#!/bin/bash

function CopyCommon() {
    echo "Copying common ...";
    if [ -d "/Build/$Organization/Common" ]; then
        sudo rm -rf /Build/$Organization/Common
    fi
    mkdir -p /Build/$Organization/Common
    cp -r /$Organization/Common /Build/$Organization/
}