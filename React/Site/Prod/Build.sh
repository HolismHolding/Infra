. /HolismHolding/Infra/React/Site/GetHolismReactSite.sh

function CopyHolismHoldingInfra() {
    echo "Copying holding base ...";
    if [ -d "/Build/HolismHolding" ]; then
        sudo rm -rf /Build/HolismHolding
    fi
    mkdir -p /Build/HolismHolding
    cp -r /HolismHolding/Infra /Build/HolismHolding/Infra
}

function CopyHolismReactSite() {
    echo "Copying site base ...";
    if [ -d "/Build/HolismReact" ]; then
        sudo rm -rf /Build/HolismReact
    fi
    mkdir -p /Build/HolismReact
    cp -r /HolismReact/Site /Build/HolismReact/Site
}

function CopySite() {
    echo "Copying site ...";
    if [ -d "/Build/$Organization/$Repository" ]; then
        sudo rm -rf /Build/$Organization/$Repository
    fi
    mkdir -p /Build/$Organization/$Repository
    cp -r /$Organization/$Repository /Build/$Organization/
}

function BuildReactSite() {
    echo "Building site ..."
    GetHolismReactSite
    CopyHolismHoldingInfra
    CopyHolismReactSite
    CopySite
    Dockerfile=/Build/Dockerfile
    envsubst < /HolismHolding/Infra/React/Site/Prod/Dockerfile > $Dockerfile
    docker build -f $Dockerfile -t ghcr.io/$LowercaseOrg/$LowercaseRepo:latest /Build
}