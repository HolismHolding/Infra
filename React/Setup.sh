#!/bin/bash

function IsReact() {
    if [ -f "App.js" ] || [ -f "Resources.js" ]; then
        return 0;
    else 
        return 1;
    fi
}

function CreateHolismReactDirectory() {
    if [ ! -d "/HolismReact" ]; then
        echo "Creating /HolismReact directory"
        sudo mkdir /HolismReact
        sudo chmod -R 777 /HolismReact
    fi
}

function GetReactInfra() {
    infraPath=/HolismReact/Infra
    if [ -d "$infraPath" ]; then
        echo "Pulling $infraPath"
        git -C $infraPath pull
    else 
        echo "Cloning $infraPath"
        git -C /HolismReact clone git@github.com:HolismReact/Infra
    fi
}

function GetReactPanel() {
    panelPath=/HolismReact/Panel
    if [ -d "$panelPath" ]; then
        echo "Pulling $panelPath"
        git -C $panelPath pull
    else 
        echo "Cloning $panelPath"
        git -C /HolismReact clone git@github.com:HolismReact/Panel
    fi
}

function GetReactAccounts() {
    accountsPath=/HolismReact/Accounts
    if [ -d "$accountsPath" ]; then
        echo "Pulling $accountsPath"
        git -C $accountsPath pull
    else 
        echo "Cloning $accountsPath"
        git -C /HolismReact clone git@github.com:HolismReact/Accounts
    fi
}

function GetDependencies() {
    if [ ! -f "$PWD/Dependencies" ]; then
        return;
    fi
    export IFS='/'
    { cat "$PWD/Dependencies"; echo; } | while read Organization Repository; do  
        echo $Organization $Repository
        if [ ! -d "/$Organization" ]; then
            sudo mkdir "/$Organization"
            sudo chmod -R 777 "/$Organization"
        fi
        if [ ! -d "/$Organization/$Repository" ]; then 
            echo "Cloning /$Organization/$Repository"
            git -C /$Organization clone git@github.com:$Organization/$Repository
        else 
            echo "Pulling /$Organization/$Repository"
            git -C /$Organization/$Repository pull
        fi
    done
}

function SetupReact() {
    echo "Seting up React"
    #CreateHolismReactDirectory
    #GetReactInfra
    #GetReactPanel
    #GetReactAccounts
    GetDependencies
    return;
    composeFile=Panel
    if [ -f "App.js" ]; then
        echo "Setting up React, panel"
        composeFile=Panel
    else
        if [ -f ".env" ]; then
            echo "Setting up React, runnable|host|app"
            composeFile=Runnable
        else
            echo "Setting up React, reusable|module|package"
            composeFile=Reusable
        fi
    fi
    docker-compose -f /Nefcanto/Infra/React/Dev/$composeFile up --remove-orphans
}