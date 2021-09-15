. /HolismHolding/Infra/Next/CreateHolismNextDirectory.sh
. /HolismHolding/Infra/Next/GetHolismNextInfra.sh

function CopyHolismHoldingInfra() {
    echo "Copying holding base ...";
    if [ -d "/Build/HolismHolding" ]; then
        sudo rm -rf /Build/HolismHolding
    fi
    mkdir -p /Build/HolismHolding
    cp -r /HolismHolding/Infra /Build/HolismHolding/Infra
}

function CopyHolismNextInfra() {
    echo "Copying site base ...";
    if [ -d "/Build/HolismReact" ]; then
        sudo rm -rf /Build/HolismReact
    fi
    mkdir -p /Build/HolismReact
    cp -r /HolismNext/Infra /Build/HolismNext/Infra
}

function CopySite() {
    echo "Copying site ...";
    if [ -d "/Build/$Organization/$Repository" ]; then
        sudo rm -rf /Build/$Organization/$Repository
    fi
    mkdir -p /Build/$Organization/$Repository
    cp -r /$Organization/$Repository /Build/$Organization/
}

function BuildNext() {
    echo "Building site ..."
    CreateHolismNextDirectory
    GetHolismNextInfra
    CopyHolismHoldingInfra
    CopyHolismNextInfra
    CopySite
    Dockerfile=/Build/Dockerfile
    envsubst < /HolismHolding/Infra/Next/Prod/Dockerfile > $Dockerfile
    docker build -f $Dockerfile -t ghcr.io/$LowercaseOrg/$LowercaseRepo:latest /Build
}