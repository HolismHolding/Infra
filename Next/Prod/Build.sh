. /HolismHolding/Infra/Next/CreateHolismNextDirectory.sh
. /HolismHolding/Infra/Next/GetHolismNextInfra.sh
. /HolismHolding/Infra/Scripts/CopyHolismHoldingInfra.sh
. /HolismHolding/Infra/Scripts/CopyDependencies.sh
. /HolismHolding/Infra/Scripts/CopyRepository.sh

function CopyHolismNextInfra() {
    echo "Copying site base ...";
    if [ -d "/Build/HolismNext" ]; then
        sudo rm -rf /Build/HolismNext
    fi
    mkdir -p /Build/HolismNext
    cp -r /HolismNext/Infra /Build/HolismNext/Infra
}

function BuildNext() {
    echo "Building site ..."

    CreateHolismNextDirectory
    GetHolismNextInfra

    CopyHolismHoldingInfra
    CopyHolismNextInfra
    CopyDependencies
    CopyRepository

    Dockerfile=/Build/Dockerfile
    envsubst < /HolismHolding/Infra/Next/Prod/Dockerfile > $Dockerfile
    docker build -f $Dockerfile -t ghcr.io/$LowercaseOrg/$LowercaseRepo:latest /Build
}