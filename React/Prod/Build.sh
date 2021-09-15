. /HolismHolding/Infra/React/CreateHolismReactDirectory.sh
. /HolismHolding/Infra/React/GetHolismReactInfra.sh

function CopyHolismHoldingInfra() {
    echo "Copying holding infra ...";
    if [ -d "/Build/HolismHolding" ]; then
        sudo rm -rf /Build/HolismHolding
    fi
    mkdir -p /Build/HolismHolding
    cp -r /HolismHolding/Infra /Build/HolismHolding/Infra
}

function CopyHolismReactInfra() {
    echo "Copying react infra ...";
    if [ -d "/Build/HolismReact" ]; then
        sudo rm -rf /Build/HolismReact
    fi
    mkdir -p /Build/HolismReact
    cp -r /HolismReact/Infra /Build/HolismReact/Infra
}

function CopyPanel() {
    echo "Copying panel ...";
    if [ -d "/Build/$Organization/$Repository" ]; then
        sudo rm -rf /Build/$Organization/$Repository
    fi
    mkdir -p /Build/$Organization/$Repository
    cp -r /$Organization/$Repository /Build/$Organization/
}

function BuildReact() {
    echo "Building panel ..."
    CreateHolismReactDirectory
    GetHolismReactInfra
    CopyHolismHoldingInfra
    CopyHolismReactInfra
    CopyPanel
    Dockerfile=/Build/Dockerfile
    envsubst < /HolismHolding/Infra/React/Prod/Dockerfile > $Dockerfile
    docker build -f $Dockerfile -t ghcr.io/$LowercaseOrg/$LowercaseRepo:latest /Build
}