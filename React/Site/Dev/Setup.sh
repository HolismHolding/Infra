. /HolismHolding/Infra/React/Site/GetHolismReactSite.sh
. /HolismHolding/Infra/React/Site/CreateBuildDirectory.sh

function PullNextDevDockerImage() {
    echo 'Pulling docker image holism/next-dev:latest'
    docker pull holism/next-dev:latest
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