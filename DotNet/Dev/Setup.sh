#!/bin/bash

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
    sudo ln -s /HolismHolding/Infra/DotNet/Dev/GitIgnore "$PWD/.gitignore"
    #git -C "$PWD" update-index --assume-unchanged "$PWD/.gitignore"
}

function PullDotNetDockerImage() {
    echo 'Pulling docker image holism/dotnet-dev:latest'
    docker pull holism/dotnet-dev:latest
}

function GetDependencies() {
    echo "Getting dependencies";
    if [ ! -f "$PWD/Dependencies" ]; then
        return;
    fi
    while read Dependency; do  
        Org=$(echo $Dependency | cut -d'/' -f1)
        Repo=$(echo $Dependency | cut -d'/' -f2)
        if [ ! -d "/$Org" ]; then
            sudo mkdir "/$Org"
            sudo chmod -R 777 "/$Org"
        fi
        if [ ! -d "/$Org/$Repo" ]; then 
            echo "Cloning /$Org/$Repo"
            git -C /$Org clone git@github.com:$Org/$Repo &
        else 
            echo "Pulling /$Org/$Repo"
            git -C /$Org/$Repo pull &
        fi
        volumes="$volumes\n            - *$Org*$Repo:*$Org*$Repo"
    done <<< "$({ cat "$PWD/Dependencies"; echo; })"
}

function SetupDotNet() {
    echo ".NET"
    GetDotNetInfra &
    GetDotNetAccounts &
    volumes=""
    GetDependencies volumes
    echo -e $volumes
    LinkGitIgnore
    PullDotNetDockerImage
    echo "DotNet, runnable|host|app"
    ComposeFile=/Temp/$Organization/$Repository/DockerCompose.yml
    mkdir -p $(dirname $ComposeFile)
    envsubst < /HolismHolding/Infra/DotNet/Dev/DockerCompose.yml > $ComposeFile
    sed -i "s/VolumeMappingPlaceHolder/$volumes/g" $ComposeFile
    sed -i "s/*/\//g" $ComposeFile
    docker-compose -p "${Organization}_${Repository}" -f $ComposeFile up --remove-orphans
}