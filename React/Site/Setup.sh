#!/bin/bash

function IsReactSite() {
    if [ -d "pages" ]; then
        return 0;
    else 
        return 1;
    fi
}

function GetReactSite() {
    infraPath=/HolismReact/Site
    if [ -d "$infraPath" ]; then
        echo "Pulling $infraPath"
        git -C $infraPath pull
    else 
        echo "Cloning $infraPath"
        git -C /HolismReact clone git@github.com:HolismReact/Site
    fi
}

function SetupReact() {
    echo "Seting up site"
    GetReactSite
    docker-compose -f /Nefcanto/Infra/React/Site/Dev/Runnable up --remove-orphans
}