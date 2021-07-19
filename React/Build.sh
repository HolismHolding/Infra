#!/bin/bash

. /HolismHolding/Infra/React/Panel/Prod/Build.sh
. /HolismHolding/Infra/React/Site/Prod/Build.sh

function CreateHolismReactDirectory() {
    if [ ! -d "/HolismReact" ]; then
        echo "Creating /HolismReact directory"
        sudo mkdir /HolismReact
        sudo chmod -R 777 /HolismReact
    fi
}

function BuildReact() {
    echo "Building React"
    CreateHolismReactDirectory
    if IsReactSite $1; then
        BuildReactSite
    else 
        BuildReactPanel
    fi
}