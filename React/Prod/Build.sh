. /HolismHolding/Infra/React/CreateHolismReactDirectory.sh
. /HolismHolding/Infra/React/GetHolismReactInfra.sh
. /HolismHolding/Infra/Scripts/CopyHolismHoldingInfra.sh
. /HolismHolding/Infra/Scripts/CopyDependencies.sh
. /HolismHolding/Infra/Scripts/CopyRepository.sh

function CopyHolismReactInfra() {
    echo "Copying HolismReact/Infra ...";
    if [ -d "/Build/HolismReact" ]; then
        sudo rm -rf /Build/HolismReact
    fi
    mkdir -p /Build/HolismReact
    cp -r /HolismReact/Infra /Build/HolismReact/Infra
}

function BuildReact() {
    echo "Building panel ..."

    CreateHolismReactDirectory
    GetHolismReactInfra

    CopyHolismHoldingInfra
    CopyHolismReactInfra
    CopyDependencies
    CopyRepository

    Dockerfile=/Build/Dockerfile
    envsubst < /HolismHolding/Infra/React/Prod/Dockerfile > $Dockerfile
    docker build -f $Dockerfile -t ghcr.io/$LowercaseOrg/$LowercaseRepo:latest /Build
}