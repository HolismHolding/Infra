#!/bin/bash

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
        rm -rf .gitignore;
    fi
    ln -s /HolismDotNet/Framework/.gitignore "$PWD/.gitignore"
    git -C "$PWD" update-index --assume-unchanged "$PWD/.gitignore"
}

function SetupDotNet() {
    echo ".NET"
    GetDotNetInfra
    GetDotNetAccounts
    LinkGitIgnore
    echo "DotNet, runnable|host|app"
    docker-compose -f /Nefcanto/Infra/DotNet/Dev/Runnable up --remove-orphans
}