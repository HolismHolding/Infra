. /HolismHolding/Infra/React/Site/GetHolismReactSite.sh

function CopyHolismHoldingInfra() {
    echo "Copying holding base ...";
    if [ -d "/Temp/$Organization/$Repository/HolismHolding" ]; then
        sudo rm -rf /Temp/$Organization/$Repository/HolismHolding
    fi
    mkdir -p /Temp/$Organization/$Repository/HolismHolding
    cp -r /HolismHolding/Infra /Temp/$Organization/$Repository/HolismHolding/Infra
}

function CopyHolismReactSite() {
    echo "Copying site base ...";
    if [ -d "/Temp/$Organization/$Repository/HolismReact" ]; then
        sudo rm -rf /Temp/$Organization/$Repository/HolismReact
    fi
    mkdir -p /Temp/$Organization/$Repository/HolismReact
    cp -r /HolismReact/Site /Temp/$Organization/$Repository/HolismReact/Site
}

function CopySite() {
    echo "Copying site ...";
    if [ -d "/Temp/$Organization/$Repository/$Organization/$Repository" ]; then
        sudo rm -rf /Temp/$Organization/$Repository/$Organization/$Repository
    fi
    mkdir -p /Temp/$Organization/$Repository/$Organization/$Repository
    cp -r /$Organization/$Repository /Temp/$Organization/$Repository/$Organization/$Repository
}

function BuildReactSite() {
    echo "Building site ..."
    GetHolismReactSite
    CopyHolismHoldingInfra
    CopyHolismReactSite
    Dockerfile=/Temp/$Organization/$Repository/Dockerfile
    envsubst < /HolismHolding/Infra/React/Site/Prod/Dockerfile > $Dockerfile
    docker build -f $Dockerfile -t ghcr.io/$LowercaseOrg/$LowercaseRepo:latest /Temp/$Organization/$Repository
}