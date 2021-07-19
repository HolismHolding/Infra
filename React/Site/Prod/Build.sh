. /HolismHolding/Infra/React/Site/GetHolismReactSite.sh

function BuildReactSite() {
    echo "Building site ..."
    GetHolismReactSite
    ComposeFile=/HolismHolding/Infra/React/Site/Prod/Runnable.yml
    envsubst < ComposeFile > $ComposeFile
    docker-compose -p "${Organization}_${Repository}" -f $ComposeFile up --remove-orphans

}