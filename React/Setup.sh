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

function SetupReact() {
    echo "Seting up React"
    CreateHolismReactDirectory
    GetReactInfra
    GetReactPanel
    GetReactAccounts
    if [ -f "App.js" ]; then
        echo "Setting up React, panel"
        docker-compose -f /Nefcanto/Infra/React/Dev/Panel up --remove-orphans 
    else
        if [ -f ".env" ]; then
            echo "Setting up React, runnable|host|app"
            docker-compose -f /Nefcanto/Infra/React/Dev/Runnable up --remove-orphans 
        else
            echo "Setting up React, reusable|module|package"
            docker-compose -f /Nefcanto/Infra/React/Dev/Reusable up --remove-orphans 
        fi
    fi
}