. /HolismHolding/Infra/React/Site/GetHolismReactSite.sh

function PullNextDevDockerImage() {
    echo 'Pulling docker image holism/next-dev:latest'
    docker pull holism/next-dev:latest
}

function CreateBuildDirectory() {
    if [ ! -d "/Temp$RepositoryPath/Build" ]; then
        echo "Creating directory: /Temp$RepositoryPath/Build";
        sudo mkdir "/Temp$RepositoryPath/Build";
        sudo chmod -R 777 "/Temp$RepositoryPath/Build";
    fi
}

function SetupReactSite() {
    echo "Seting up site"
    GetHolismReactSite
    PullNextDevDockerImage
    ComposeFile=/Temp/$Organization/$Repository/Runnable.yml
    mkdir -p $(dirname $ComposeFile)
    CreateBuildDirectory
    envsubst < /HolismHolding/Infra/React/Site/Dev/Runnable.yml > $ComposeFile
    docker-compose -p "${Organization}_${Repository}" -f $ComposeFile up --remove-orphans
}