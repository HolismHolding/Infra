#!/bin/bash

. /Nefcanto/Infra/React/Site/Setup.sh
. /Nefcanto/Infra/React/Panel/Setup.sh

function IsReact() {
    if IsReactSite $1 || IsReactPanel $1; then
        return 0
    else
        return 1
    fi
}

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