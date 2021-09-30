#!/bin/bash

. /HolismHolding/Infra/Scripts/GetDotNetInfra.sh
. /HolismHolding/Infra/Scripts/GetDotNetAccounts.sh
. /HolismHolding/Infra/Scripts/LinkGitIgnore.sh
. /HolismHolding/Infra/Scripts/GetDependencies.sh
. /HolismHolding/Infra/DotNet/LinkLocalSecrets
. /HolismHolding/Infra/DotNet/CreateApiContainer
. /HolismHolding/Infra/SqlServer/Dev/CreateDatabaseContainer

function PullDotNetDockerImage() {
    echo 'Pulling docker image holism/dotnet-dev:latest'
    docker pull holism/dotnet-dev:latest
}

function GetDependenciesActions()
{
    echo "Getting dependencies actions";
    if [ ! -f "$PWD/Dependencies" ]; then
        return;
    fi
    while read Dependency; do  
        
        export Org=$(echo $Dependency | cut -d'/' -f1)
        export Repo=$(echo $Dependency | cut -d'/' -f2)

        Yaml=$(cat /HolismHolding/Infra/DotNet/GetRepositoryAction.yml)
        DependencyAction=$(envsubst <<< "$Yaml")

        DependencyActions="$DependencyActions\n\n$DependencyAction"

    done <<< "$({ cat "$PWD/Dependencies"; echo; })"
}

function CreateGitHubActionForDotNet()
{
    GitHubActionPath=/$Organization/$Repository/.github/workflows/BuildAndPushDockerImage.yml
    mkdir -p $(dirname $GitHubActionPath)
    export GITHUB_WORKSPACE="$""GITHUB_WORKSPACE"

    DependencyActions=""
    GetDependenciesActions DependencyActions

    envsubst < /HolismHolding/Infra/DotNet/GitHubAction.yml > $GitHubActionPath
    Temp=$(cat $GitHubActionPath)

    echo -e "${Temp/GettingDependenciesRepositoriesPlacholder/"$DependencyActions"}" > $GitHubActionPath 

    echo "Created GitHub action"
}

function SetupDotNet() {
    echo ".NET"
    GetDotNetInfra &
    GetDotNetAccounts &
    volumes=""
    GetDependencies volumes
    #echo -e $volumes
    LinkGitIgnore $PWD
    LinkLocalSecrets
    PullDotNetDockerImage
    CreateGitHubActionForDotNet
    
    CreateDatabaseContainer
    CreateApiContainer "Dev"
}