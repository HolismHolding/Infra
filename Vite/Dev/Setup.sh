. /HolismHolding/Infra/Vite/CreateHolismViteDirectory.sh
. /HolismHolding/Infra/Vite/GetHolismViteInfra.sh
. /HolismHolding/Infra/Scripts/LinkGitIgnore.sh
. /HolismHolding/Infra/Scripts/CreateGitHubAction.sh

function PullViteDockerImage() {
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

function SetupVite() {
    CreateHolismViteDirectory
    GetHolismViteInfra &
    PullViteDockerImage
    LinkGitIgnore $PWD
    CreateGitHubAction Vite
    volumes=""
    GetDependencies volumes
    echo -e $volumes

    ComposePath=/Temp/$Organization/$Repository/DockerCompose.yml
    mkdir -p $(dirname $ComposePath)
    CreateBuildDirectory
    envsubst < /HolismHolding/Infra/Vite/Dev/DockerCompose.yml > $ComposePath
    sed -i "s/VolumeMappingPlaceHolder/$volumes/g" $ComposePath
    sed -i "s/*/\//g" $ComposePath
    echo "Using docker-compose file => $ComposePath"
    docker-compose -p "${Organization}_${Repository}" -f $ComposePath up --remove-orphans
}