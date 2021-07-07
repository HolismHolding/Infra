#!/bin/bash

. /HolismHolding/Infra/CommonFunctions.sh

function IsDotNet() {
    sln=$(find "$PWD" -name *.sln|head -n1)
    if [ ! -z "$sln" ]; then
        return 0;
    else 
        return 1;
    fi
}

function GetDotNetInfra() {
    infraPath=/HolismDotNet/Infra
    if [ -d "$infraPath" ]; then
        echo "Pulling $infraPath"
        git -C $infraPath pull
    else 
        echo "Cloning $infraPath"
        git -C /HolismDotNet clone git@github.com:HolismDotNet/Infra
    fi
    infraPath=/HolismDotNet/Framework
    if [ -d "$infraPath" ]; then
        echo "Pulling $infraPath"
        git -C $infraPath pull
    else 
        echo "Cloning $infraPath"
        git -C /HolismDotNet clone git@github.com:HolismDotNet/Framework
    fi
}

function GetDotNetAccounts() {
    accountsPath=/HolismDotNet/Accounts
    if [ -d "$accountsPath" ]; then
        echo "Pulling $accountsPath"
        git -C $accountsPath pull
    else 
        echo "Cloning $accountsPath"
        git -C /HolismDotNet clone git@github.com:HolismDotNet/Accounts
    fi
}

function LinkGitIgnore() {
    if [ -f "$PWD/.gitignore" ]; then
        sudo rm -rf "$PWD/.gitignore"
    fi
    ln -s /HolismHolding/Infra/DotNet/Dev/GitIgnore "$PWD/.gitignore"
    git -C "$PWD" update-index --assume-unchanged "$PWD/.gitignore"
}

function PullDockerImage() {
    echo 'Pulling docker image holism/dotnet-dev:latest'
    docker pull holism/dotnet-dev:latest
}

function SetupDotNet() {
    echo ".NET"
    GetDotNetInfra
    GetDotNetAccounts
    volumes=""
    GetDependencies volumes
    echo -e $volumes
    LinkGitIgnore
    PullDockerImage
    echo "DotNet, runnable|host|app"
    cp /HolismHolding/Infra/DotNet/Dev/Runnable.yml /Temp/DotNetDevRunnable.yml
    sed -i "s/VolumeMappingPlaceHolder/$volumes/g" /Temp/DotNetDevRunnable.yml
    sed -i "s/*/\//g" /Temp/DotNetDevRunnable.yml
    docker-compose -f /Temp/DotNetDevRunnable.yml up --remove-orphans
}