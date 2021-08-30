#!/bin/bash

. /HolismHolding/Infra/Scripts/GetDotNetInfra.sh
. /HolismHolding/Infra/Scripts/GetDotNetAccounts.sh
. /HolismHolding/Infra/Scripts/LinkGitIgnore.sh
. /HolismHolding/Infra/Scripts/GetDependencies.sh


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
    echo -e $volumes
    LinkGitIgnore $PWD
    PullDotNetDockerImage
    echo "DotNet, runnable|host|app"
    ComposeFile=/Temp/$Organization/$Repository/DockerCompose.yml
    mkdir -p $(dirname $ComposeFile)
    envsubst < /HolismHolding/Infra/DotNet/Dev/DockerCompose.yml > $ComposeFile
    sed -i "s/VolumeMappingPlaceHolder/$volumes/g" $ComposeFile
    sed -i "s/*/\//g" $ComposeFile
    docker-compose -p "${Organization}_${Repository}" -f $ComposeFile up --remove-orphans
}