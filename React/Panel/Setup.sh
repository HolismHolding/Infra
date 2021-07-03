#!/bin/bash

function IsReactPanel() {
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
    echo "Getting dependencies";
    if [ ! -f "$PWD/Dependencies" ]; then
        return;
    fi
    OLDIFS=$IFS
    export IFS='/'
    while read Org Repo; do  
        echo $Org $Repo
        if [ ! -d "/$Org" ]; then
            sudo mkdir "/$Org"
            sudo chmod -R 777 "/$Org"
        fi
        if [ ! -d "/$Org/$Repo" ]; then 
            echo "Cloning /$Org/$Repo"
            git -C /$Org clone git@github.com:$Org/$Repo
        else 
            echo "Pulling /$Org/$Repo"
            git -C /$Org/$Repo pull
        fi
        volumes="$volumes\n            - *$Org*$Repo:*\${Repo}*src*$Repo"
    done <<< "$({ cat "$PWD/Dependencies"; echo; })"
    IFS=$OLDIFS
}

function SetupReactPanel() {
    echo "Setting up panel"
    GetReactInfra
    GetReactPanel
    GetReactAccounts
    volumes=""
    GetDependencies volumes
    echo -e $volumes
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
    cp /Nefcanto/Infra/React/Panel/Dev/$composeFile.yml /Temp/ReactPanelDev$composeFile.yml
    sed -i "s/VolumeMappingPlaceHolder/$volumes/g" /Temp/ReactPanelDev$composeFile.yml
    sed -i "s/*/\//g" /Temp/ReactPanelDev$composeFile.yml
    echo "Using docker-compose file => /Temp/ReactPanelDev$composeFile.yml"
    echo $Repository
    echo $Organization
    echo $OrganizationPrefix
    echo $RepositoryPath
    docker-compose -f /Temp/ReactPanelDev$composeFile.yml up --remove-orphans
}