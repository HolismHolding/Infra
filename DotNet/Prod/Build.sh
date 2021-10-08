. /HolismHolding/Infra/Scripts/CopyHolismHoldingInfra.sh
. /HolismHolding/Infra/Scripts/CopyDependencies.sh
. /HolismHolding/Infra/Scripts/CopyRepository.sh

function CopyHolismDotNetInfra() {
    echo "Copying HolismDotNet/Infra ...";
    mkdir /Build/HolismDotNet
    cp -r /HolismDotNet/Infra /Build/HolismDotNet/Infra
    cp -r /HolismDotNet/Accounts /Build/HolismDotNet/Accounts
}

function RemoveBinsAndObjs() {
    echo "Removing bin and obj directories ..."
    find /Build -type d -name "bin" | xargs sudo rm -rf
    find /Build -type d -name "obj" | xargs sudo rm -rf
}

function RemoveLocalSecrets() {
    echo "Removing local secrets"
    find . | grep LocalSecrets | xargs sudo rm -rf
}

function BuildDotNet() {

    CopyHolismHoldingInfra
    CopyHolismDotNetInfra
    CopyDependencies
    CopyRepository

    RemoveBinsAndObjs
    RemvoeGits
    RemoveLocalSecrets

    Dockerfile=/Build/Dockerfile
    envsubst < /HolismHolding/Infra/DotNet/Prod/Dockerfile > $Dockerfile
    docker build -f $Dockerfile -t ghcr.io/$LowercaseOrg/$LowercaseRepo:latest /Build
}