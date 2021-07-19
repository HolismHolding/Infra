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

function PullReactDockerImage() {
    echo 'Pulling docker image holism/react-dev:latest'
    docker pull holism/react-dev:latest
}

function CreateBuildDirectory() {
    if [ ! -d "/Temp$RepositoryPath/Build" ]; then
        echo "Creating directory: /Temp$RepositoryPath/Build";
        sudo mkdir "/Temp$RepositoryPath/Build";
        sudo chmod -R 777 "/Temp$RepositoryPath/Build";
    fi
}

function SetupReactPanel() {
    GetReactInfra
    GetReactPanel
    GetReactAccounts
    PullReactDockerImage
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
            composeFile=Runnable
        fi
    fi

    ComposePath=/Temp/$Organization/$Repository/$composeFile.yml
    mkdir -p $(dirname $ComposePath)
    CreateBuildDirectory
    envsubst < /HolismHolding/Infra/React/Panel/Dev/$composeFile.yml > $ComposePath
    sed -i "s/VolumeMappingPlaceHolder/$volumes/g" $ComposePath
    sed -i "s/*/\//g" $ComposePath
    echo "Using docker-compose file => $ComposePath"
    docker-compose -p "${Organization}_${Repository}" -f $ComposePath up --remove-orphans
}