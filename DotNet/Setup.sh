#!/bin/bash

function IsDotNet() {
    sln=$(find "$PWD" -name *.sln|head -n1)
    if [ ! -z "$sln" ]; then
        return 1;
    else 
        return 0;
    fi
}

function GetDotNetInfra() {
    infraPath=/HolismDotNet/Infra
    if [ -d "$infraPath" ]; then
        echo "Pulling $infraPath"
        git -C $infraPath pull
    else 
        echo "Cloning $infraPath"
        git -C $infraPath clone git@github.com:HolismDotNet/Infra
    fi
    infraPath=/HolismDotNet/Framework
    if [ -d "$infraPath" ]; then
        echo "Pulling $infraPath"
        git -C $infraPath pull
    else 
        echo "Cloning $infraPath"
        git -C $infraPath clone git@github.com:HolismDotNet/Framework
    fi
}

function GetDotNetAccounts() {
    accountsPath=/HolismDotNet/Accounts
    if [ -d "$accountsPath" ]; then
        echo "Pulling $accountsPath"
        git -C $accountsPath pull
    else 
        echo "Cloning $accountsPath"
        git -C $accountsPath clone git@github.com:HolismDotNet/Accounts
    fi
}

function SetupDotNet() {
    echo "DotNet"
    GetDotNetInfra
    GetDotNetAccounts
    echo "DotNet, runnable|host|app"
    docker-compose -f Nefcanto/Infra/DotNet/Dev/Runnable up
}