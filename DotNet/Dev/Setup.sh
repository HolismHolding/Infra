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

function SetupDotNet() {
    echo ".NET"
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