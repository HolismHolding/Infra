#!/bin/bash

function IsLaravel() {
    if [ -f "composer.json" ]; then
        return 0;
    else 
        return 1;
    fi
}

function CreateHolismLaravelDirectory() {
    if [ ! -d "/HolismLaravel" ]; then
        echo "Creating /HolismLaravel directory"
        sudo mkdir /HolismLaravel
        sudo chmod -R 777 /HolismLaravel
    fi
}

function GetLaravelInfra() {
    infraPath=/HolismLaravel/Infra
    if [ -d "$infraPath" ]; then
        echo "Pulling $infraPath"
        git -C $infraPath pull
    else 
        echo "Cloning $infraPath"
        git -C /HolismLaravel clone git@github.com:HolismLaravel/Infra
    fi
}

function GetLaravelAccounts() {
    accountsPath=/HolismLaravel/Accounts
    if [ -d "$accountsPath" ]; then
        echo "Pulling $accountsPath"
        git -C $accountsPath pull
    else 
        echo "Cloning $accountsPath"
        git -C /HolismLaravel clone git@github.com:HolismLaravel/Accounts
    fi
}

function GetDependencies() {
    echo "Getting dependencies";
    if [ ! -f "$PWD/Dependencies" ]; then
        return;
    fi
    export IFS='/'
    while read Organization Repository; do  
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
        volumes="$volumes\n            - *$Organization*$Repository:*\${Repository}*src*$Repository"
    done <<< "$({ cat "$PWD/Dependencies"; echo; })"
}

function SetupLaravel() {
    echo "Seting up Laravel"
    CreateHolismLaravelDirectory
    GetLaravelInfra
    GetLaravelPanel
    GetLaravelAccounts
    volumes=""
    GetDependencies volumes
    echo -e $volumes
    composeFile=Panel
    if [ -f "App.js" ]; then
        echo "Setting up Laravel, panel"
        composeFile=Panel
    else
        if [ -f ".env" ]; then
            echo "Setting up Laravel, runnable|host|app"
            composeFile=Repository
        else
            echo "Setting up Laravel, reusable|module|package"
            composeFile=Reusable
        fi
    fi
    cp /Nefcanto/Infra/Laravel/Dev/$composeFile /Temp/LaravelDev$composeFile
    sed -i "s/VolumeMappingPlaceHolder/$volumes/g" /Temp/LaravelDev$composeFile
    sed -i "s/*/\//g" /Temp/LaravelDev$composeFile
    docker-compose -f /Temp/LaravelDev$composeFile up --remove-orphans
}