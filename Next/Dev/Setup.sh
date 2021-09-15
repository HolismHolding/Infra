. /HolismHolding/Infra/Next/CreateHolismNextDirectory.sh
. /HolismHolding/Infra/Next/GetHolismNextInfra.sh

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

function SetupNext() {
    echo "Seting up site"
    CreateHolismNextDirectory
    GetHolismNextInfra
    PullNextDevDockerImage
    ComposeFile=/Temp/$Organization/$Repository/Runnable.yml
    mkdir -p $(dirname $ComposeFile)
    CreateBuildDirectory
    envsubst < /HolismHolding/Infra/Next/Dev/Runnable.yml > $ComposeFile
    docker-compose -p "${Organization}_${Repository}" -f $ComposeFile up --remove-orphans
}