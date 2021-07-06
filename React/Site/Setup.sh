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

function CreateBuildDirectory() {
    if [ ! -d "/Temp$RepositoryPath/Build" ]; then
        echo "Creadin directory: /Temp$RepositoryPath/Build";
        sudo mkdir "/Temp$RepositoryPath/Build";
        sudo chmod -R 777 "/Temp$RepositoryPath/Build";
    fi
}

function SetupReactSite() {
    echo "Seting up site"
    GetReactSite
    CreateBuildDirectory
    docker-compose -f /HolismHolding/Infra/React/Site/Dev/Runnable.yml up --remove-orphans
}