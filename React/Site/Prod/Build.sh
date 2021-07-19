. /HolismHolding/Infra/React/Site/GetHolismReactSite.sh

function BuildReactSite() {
    echo "Building site ..."
    GetHolismReactSite
    ComposeFile=/Temp/$Organization/$Repository/Runnable.yml
    mkdir -p $(dirname $ComposeFile)
    CreateBuildDirectory
    envsubst < /HolismHolding/Infra/React/Site/Dev/Runnable.yml > $ComposeFile
    docker-compose -p "${Organization}_${Repository}" -f $ComposeFile up --remove-orphans

}