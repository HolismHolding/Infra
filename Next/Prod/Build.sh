. /HolismHolding/Infra/Next/CreateHolismNextDirectory.sh
. /HolismHolding/Infra/Next/GetHolismNextInfra.sh
. /HolismHolding/Infra/Scripts/CopyHolismHoldingInfraForBuild.sh

function CopyHolismNextInfra() {
    echo "Copying site base ...";
    if [ -d "/Build/HolismNext" ]; then
        sudo rm -rf /Build/HolismNext
    fi
    mkdir -p /Build/HolismNext
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
    CopyHolismHoldingInfraForBuild
    CopyHolismNextInfra
    CopySite
    Dockerfile=/Build/Dockerfile
    envsubst < /HolismHolding/Infra/Next/Prod/Dockerfile > $Dockerfile
    docker build -f $Dockerfile -t ghcr.io/$LowercaseOrg/$LowercaseRepo:latest /Build
}