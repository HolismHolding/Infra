#!/bin/bash

. /HolismHolding/Infra/Scripts/GetDotNetInfra.sh
. /HolismHolding/Infra/Scripts/GetDotNetAccounts.sh
. /HolismHolding/Infra/Scripts/LinkGitIgnore.sh
. /HolismHolding/Infra/Scripts/GetDependencies.sh
. /HolismHolding/Infra/DotNet/LinkLocalSecrets
. /HolismHolding/Infra/DotNet/CreateApiContainer
. /HolismHolding/Infra/Maria/Dev/CreateDatabaseContainer
. /HolismHolding/Infra/Storage/Dev/CreateStorageContainer
. /HolismHolding/Infra/Scripts/CreateGitHubAction.sh
. /HolismHolding/Infra/DotNet/LinkUsings.sh
. /HolismHolding/Infra/DotNet/LinkApiDependencies.sh
. /HolismHolding/Infra/DotNet/LinkApiSolution.sh
. /HolismHolding/Infra/DotNet/LinkApiCsproj.sh
. /HolismHolding/Infra/DotNet/LinkConnectionStrings.sh
. /HolismHolding/Infra/DotNet/LinkSettings.sh
. /HolismHolding/Infra/DotNet/Dev/LinkDependencies

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

function InsertInitialData()
{
    if [ -d /$Organization/Common ] && [ -f /$Organization/Common/InitialData.sql ]; then
        docker exec -i ${Organization}Databases mysql -u root -pIC1joYMLZTT0fQMJ5qcz < /$Organization/Common/InitialData.sql
    fi
}

function CreateDatabaseGitHubAction()
{
    if [[ $Repository != "AdminApi" ]]; then
        return;
    fi
    GitHubActionPath=/$Organization/$Repository/.github/workflows/ScriptProductionDatabase.yml
    mkdir -p $(dirname $GitHubActionPath)
    export GITHUB_WORKSPACE="$""GITHUB_WORKSPACE"

    envsubst < /HolismHolding/Infra/DotNet/ScriptProductionDatabase.yml > $GitHubActionPath
}

function GetDotNetGeneration() {
    generartionPath=/HolismDotNet/Generation
    if [ -d "$generartionPath" ]; then
        echo "Pulling $generartionPath"
        git -C $generartionPath pull
    else
        sudo mkdir -p /HolismDotNet
        sudo chmod -R 777 /HolismDotNet
        echo "Cloning $generartionPath"
        git -C /HolismDotNet clone git@github.com:HolismDotNet/Generation
    fi
    sudo chmod -R 777 /HolismDotNet
}

function GetDotNetMigration() {
    migrationPath=/HolismDotNet/Migration
    if [ -d "$migrationPath" ]; then
        echo "Pulling $migrationPath"
        git -C $migrationPath pull
    else
        sudo mkdir -p /HolismDotNet
        sudo chmod -R 777 /HolismDotNet
        echo "Cloning $migrationPath"
        git -C /HolismDotNet clone git@github.com:HolismDotNet/Migration
    fi
    sudo chmod -R 777 /HolismDotNet
}

function SetupDotNet() {
    echo ".NET"
    LinkDevContainer
    LinkVSCodeFiles
    GetDotNetInfra &
    GetDotNetAccounts &
    GetDotNetGeneration &
    GetDotNetMigration &
    volumes=""
    GetDependencies volumes
    LinkGitIgnore $PWD
    LinkUsings
    LinkApiDependencies
    LinkLocalSecrets
    LinkApiSolution
    LinkApiCsproj
    LinkConnectionStrings
    LinkSettings
    LinkDependencies
    PullDotNetDockerImage
    CreateGitHubAction DotNet
    CreateDatabaseGitHubAction
    
    CreateStorageContainer
    CreateDatabaseContainer
    InsertInitialData
    CreateApiContainer "Dev"
}