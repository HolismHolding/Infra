#!/bin/bash

. /HolismHolding/Infra/React/Site/Dev/Setup.sh
. /HolismHolding/Infra/React/Panel/Dev/Setup.sh

function CreateHolismReactDirectory() {
    if [ ! -d "/HolismReact" ]; then
        echo "Creating /HolismReact directory"
        sudo mkdir /HolismReact
        sudo chmod -R 777 /HolismReact
    fi
}

function SetupReact() {
    echo "Seting up React"
    CreateHolismReactDirectory
    if IsReactSite $1; then
        SetupReactSite
    else 
        SetupReactPanel
    fi
}