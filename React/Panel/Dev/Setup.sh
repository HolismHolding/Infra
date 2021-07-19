. /HolismHolding/Infra/React/Panel/GetReactInfra.sh
. /HolismHolding/Infra/React/Panel/GetReactPanel.sh
. /HolismHolding/Infra/React/Panel/GetReactAccounts.sh

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