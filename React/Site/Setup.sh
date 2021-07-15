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

function SetupHost() {
    if [ ! -f "/$Organization/$Repository/Host" ]; then
        return;
    fi
    read Host < /$Organization/$Repository/Host;
    export Host;
    if ! grep -q $Host /etc/hosts; then
        echo $Host >> /etc/hosts;
    fi
    if [ -f "/etc/nginx/conf.d/$Host.conf" ]; then
        sed -i "s/localhost:.*;/localhost:$RandomPort;/g" /etc/nginx/conf.d/$Host.conf
    else
        envsubst < /HolismHolding/Infra/NginxReverseProxyTemplate > /etc/nginx/conf.d/$Host.conf
    fi
    systemctl reload nginx
}

function SetupReactSite() {
    echo "Seting up site"
    GetReactSite
    GetRandomPort
    SetupHost
    ComposeFile=/Temp/$Organization/$Repository/Runnable.yml
    mkdir -p $(dirname $ComposeFile)
    CreateBuildDirectory
    envsubst < /HolismHolding/Infra/React/Site/Dev/Runnable.yml > $ComposeFile
    docker-compose -p "${Organization}_${Repository}" -f $ComposeFile up --remove-orphans
}