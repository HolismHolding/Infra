#!/bin/bash

function LinkDevContainer() {
    
    if [ -d "$PWD/.devcontainer" ]; then
        sudo rm -rf "$PWD/.devcontainer"
    fi

    sudo mkdir $PWD/.devcontainer
    sudo chmod -R 777 $PWD/.devcontainer
    sudo ln -s /HolismHolding/Infra/DotNet/Debug/devcontainer "$PWD/.devcontainer/devcontainer.json"
}


function LinkVScodefiles() {
    if [ -d "$PWD/.vscode" ]; then
        sudo rm -rf "$PWD/.vscode"
    fi
    sudo mkdir $PWD/.vscode
    sudo chmod -R 777 $PWD/.vscode
    
    sudo ln -s /HolismHolding/Infra/DotNet/Debug/launch "$PWD/.vscode/launch.json"
    sudo ln -s /HolismHolding/Infra/DotNet/Debug/tasks "$PWD/.vscode/tasks.json"
}

function PullDotNetDockerImage() {
    echo 'Pulling docker image: holism/dotnet-debug:latest'
    docker pull holism/dotnet-debug:latest
}

GetDotNetInfra &
GetDotNetAccounts &
volumes=""
GetDependencies volumes
echo -e $volumes
LinkGitIgnore $PWD
# PullDotNetDockerImage    echo "DotNet, runnable|host|app"
LinkDevContainer
LinkVScodefiles
ComposeFile=/Temp/$Organization/$Repository/debug.yml
mkdir -p $(dirname $ComposeFile)
envsubst < /HolismHolding/Infra/DotNet/Debug/debug.yml > $ComposeFile
sed -i "s/VolumeMappingPlaceHolder/$volumes/g" $ComposeFile
sed -i "s/*/\//g" $ComposeFile
docker-compose -p "${Organization}_${Repository}" -f $ComposeFile up --remove-orphans