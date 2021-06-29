#!/bin/bash

function IsReact() {
    if [ -f "App.js" ] || [ -f "Resources.js" ]; then
        return 0;
    else 
        return 1;
    fi
}

function GetReactInfra() {
    infraPath=/HolismReact/Infra
    if [ -d "$infraPath" ]; then
        echo "Pulling $infraPath"
        git -C $infraPath pull
    else 
        echo "Cloning $infraPath"
        git -C $infraPath clone git@github.com:HolismReact/Infra
    fi
}

function GetReactPanel() {
    panelPath=/HolismReact/Panel
    if [ -d "$panelPath" ]; then
        echo "Pulling $panelPath"
        git -C $panelPath pull
    else 
        echo "Cloning $panelPath"
        git -C $panelPath clone git@github.com:HolismReact/Panel
    fi
}

function GetReactAccounts() {
    accountsPath=/HolismReact/Accounts
    if [ -d "$accountsPath" ]; then
        echo "Pulling $accountsPath"
        git -C $accountsPath pull
    else 
        echo "Cloning $accountsPath"
        git -C $accountsPath clone git@github.com:HolismReact/Accounts
    fi
}

function SetupReact() {
    echo "React"
    GetReactInfra
    GetReactPanel
    GetReactAccounts
    if [ -f "App.js" ]; then
        echo "React, panel"
        docker-compose -f Nefcanto/Infra/React/Dev/Panel up
    else
        if [ -f ".env" ]; then
            echo "React, runnable|host|app"
            docker-compose -f Nefcanto/Infra/React/Dev/Runnable up
        else
            echo "React, reusable|module|package"
            docker-compose -f Nefcanto/Infra/React/Dev/Reusable up
        fi
    fi
}