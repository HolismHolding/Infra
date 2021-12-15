#!/bin/bash

# debug is better to work both inside .sln directory and .csproj directory
# have a fallback of what project should be debugged, based on conventional naming (for example if none is provided, debug Api/Api.csproj)

. /HolismHolding/Infra/Scripts/GetDotNetInfra.sh
. /HolismHolding/Infra/Scripts/LinkGitIgnore.sh
. /HolismHolding/Infra/Scripts/GetDependencies.sh
. /HolismHolding/Infra/DotNet/LinkLocalSecrets
. /HolismHolding/Infra/DotNet/CreateApiContainer
. /HolismHolding/Infra/SqlServer/Dev/CreateDatabaseContainer
. /HolismHolding/Infra/DotNet/LinkUsings.sh

function LinkDevContainer() {
    
    if [ -d "$PWD/$SelectedProject/.devcontainer" ]; then
        sudo rm -rf "$PWD/$SelectedProject/.devcontainer"
    fi

    sudo mkdir $PWD/$SelectedProject/.devcontainer
    sudo chmod -R 777 $PWD/$SelectedProject/.devcontainer
    sudo ln -s /HolismHolding/Infra/DotNet/Debug/DevContainer "$PWD/$SelectedProject/.devcontainer/devcontainer.json"
}

function LinkVSCodeFiles() {
    if [ -d "$PWD/$SelectedProject/.vscode" ]; then
        sudo rm -rf "$PWD/$SelectedProject/.vscode"
    fi
    sudo mkdir $PWD/$SelectedProject/.vscode
    sudo chmod -R 777 $PWD/$SelectedProject/.vscode

    envsubst < /HolismHolding/Infra/DotNet/Debug/Lunch > $PWD/$SelectedProject/.vscode/launch.json
    envsubst < /HolismHolding/Infra/DotNet/Debug/Tasks > $PWD/$SelectedProject/.vscode/tasks.json
}

function PullDotNetDockerImage() {
    echo 'Pulling docker image: holism/dotnet-debug:latest'
    docker pull holism/dotnet-debug:latest
}

function DebugDotNet() {

    if [ -z "$SelectedProject" ]; then
        if [ ! -d "$PWD/Api" ]; then
            echo -e '\033[0;31m'"You should provide the project name to debug";
            exit;
        fi
        if [ -f "$PWD/Api/Startup.cs" ]; then
            echo -e '\033[0;31m'"You are debugging in the wrong directory";
            exit;
        fi
        export SelectedProject=Api
    fi

    GetDotNetInfra &
    volumes=""
    if [ $RepositoryPath != '/HolismDotNet/Infra' ]; then
        volumes=$(sed 's/\//*/g' <<< "\n            - ${RepositoryPath}:${RepositoryPath}");
    fi
    GetDependencies volumes
    echo -e $volumes
    LinkGitIgnore $PWD
    LinkLocalSecrets
    PullDotNetDockerImage
    LinkDevContainer
    LinkVSCodeFiles
    LinkUsings

    CreateDatabaseContainer
    CreateApiContainer "Debug"
}