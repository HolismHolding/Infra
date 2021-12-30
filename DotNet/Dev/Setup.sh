#!/bin/bash

. /HolismHolding/Infra/Scripts/GetDotNetInfra.sh
. /HolismHolding/Infra/Scripts/GetDotNetAccounts.sh
. /HolismHolding/Infra/Scripts/LinkGitIgnore.sh
. /HolismHolding/Infra/Scripts/GetDependencies.sh
. /HolismHolding/Infra/DotNet/LinkLocalSecrets
. /HolismHolding/Infra/DotNet/CreateApiContainer
. /HolismHolding/Infra/SqlServer/Dev/CreateDatabaseContainer
. /HolismHolding/Infra/Scripts/CreateGitHubAction.sh
. /HolismHolding/Infra/DotNet/LinkUsings.sh
. /HolismHolding/Infra/DotNet/LinkApiSolution.sh
. /HolismHolding/Infra/DotNet/LinkConnectionStrings.sh
. /HolismHolding/Infra/DotNet/LinkSettings.sh

function PullDotNetDockerImage() {
    echo 'Pulling docker image holism/dotnet-dev:latest'
    docker pull holism/dotnet-dev:latest
}

function LinkDevContainer() {
    
    if [ -d "/$Organization/$Repository/.devcontainer" ]; then
        sudo rm -rf "/$Organization/$Repository/.devcontainer"
    fi

    sudo mkdir /$Organization/$Repository/.devcontainer
    sudo chmod -R 777 /$Organization/$Repository/.devcontainer
    envsubst < /HolismHolding/Infra/DotNet/Dev/DevContainer > "/$Organization/$Repository/.devcontainer/devcontainer.json"
}

function LinkVSCodeFiles() {
    if [ -d "/$Organization/$Repository/.vscode" ]; then
        sudo rm -rf "/$Organization/$Repository/.vscode"
    fi
    sudo mkdir /$Organization/$Repository/.vscode
    sudo chmod -R 777 /$Organization/$Repository/.vscode

    envsubst < /HolismHolding/Infra/DotNet/Dev/Lunch > /$Organization/$Repository/.vscode/launch.json
    envsubst < /HolismHolding/Infra/DotNet/Dev/Tasks > /$Organization/$Repository/.vscode/tasks.json
}

function SetupDotNet() {
    echo ".NET"
    LinkDevContainer
    LinkVSCodeFiles
    # return;
    GetDotNetInfra &
    GetDotNetAccounts &
    volumes=""
    GetDependencies volumes
    #echo -e $volumes
    LinkGitIgnore $PWD
    LinkUsings
    LinkLocalSecrets
    LinkApiSolution
    LinkConnectionStrings
    LinkSettings
    PullDotNetDockerImage
    CreateGitHubAction DotNet
    
    CreateDatabaseContainer
    CreateApiContainer "Dev"
}