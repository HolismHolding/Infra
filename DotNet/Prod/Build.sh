. /HolismHolding/Infra/Scripts/CopyHolismHoldingInfra.sh
. /HolismHolding/Infra/Scripts/CopyDependencies.sh
. /HolismHolding/Infra/Scripts/CopyRepository.sh
. /HolismHolding/Infra/Scripts/RemoveGitsDirectory.sh

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

function SetRepositoryNameInConnectionStringsFile()
{
    sed -i "s/Repository/$Repository/g" /Build/$Organization/$Repository/ConnectionStrings.json
}

function BuildDotNet() {

    CopyHolismHoldingInfra
    CopyHolismDotNetInfra
    CopyDependencies
    CopyRepository

    RemoveBinsAndObjs
    RemoveGitsDirectory
    RemoveLocalSecrets
    SetRepositoryNameInConnectionStringsFile

    envsubst < /HolismHolding/Infra/DotNet/Prod/Dockerfile > $Dockerfile
}