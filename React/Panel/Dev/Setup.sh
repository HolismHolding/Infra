. /HolismHolding/Infra/React/Panel/GetReactInfra.sh

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
    GetReactInfra &
    PullReactDockerImage
    volumes=""
    GetDependencies volumes
    echo -e $volumes

    ComposePath=/Temp/$Organization/$Repository/DockerCompose.yml
    mkdir -p $(dirname $ComposePath)
    CreateBuildDirectory
    envsubst < /HolismHolding/Infra/React/Panel/Dev/DockerCompose.yml > $ComposePath
    sed -i "s/VolumeMappingPlaceHolder/$volumes/g" $ComposePath
    sed -i "s/*/\//g" $ComposePath
    echo "Using docker-compose file => $ComposePath"
    docker-compose -p "${Organization}_${Repository}" -f $ComposePath up --remove-orphans
}