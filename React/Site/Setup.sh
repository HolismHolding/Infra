#!/bin/bash

. /HolismHolding/Infra/Scripts/GetRandomPort.sh

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

function CreateBuildDirectory() {
    if [ ! -d "/Temp$RepositoryPath/Build" ]; then
        echo "Creating directory: /Temp$RepositoryPath/Build";
        sudo mkdir "/Temp$RepositoryPath/Build";
        sudo chmod -R 777 "/Temp$RepositoryPath/Build";
    fi
}

function SetupReactSite() {
    echo "Seting up site"
    GetReactSite
    GetRandomPort
    ComposeFile=/Temp/$Organization/$Repository/Runnable.yml
    mkdir -p $(dirname $ComposeFile)
    CreateBuildDirectory
    envsubst < /HolismHolding/Infra/React/Site/Dev/Runnable.yml > $ComposeFile
    docker-compose -f $ComposeFile up --remove-orphans
}