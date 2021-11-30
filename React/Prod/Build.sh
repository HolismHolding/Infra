. /HolismHolding/Infra/React/CreateHolismReactDirectory.sh
. /HolismHolding/Infra/React/GetHolismReactInfra.sh
. /HolismHolding/Infra/Scripts/CopyHolismHoldingInfra.sh
. /HolismHolding/Infra/Scripts/CopyDependencies.sh
. /HolismHolding/Infra/Scripts/CopyRepository.sh
. /HolismHolding/Infra/Scripts/RemoveGitsDirectory.sh

function CopyHolismReactInfra() {
    echo "Copying HolismReact/Infra ...";
    if [ -d "/Build/HolismReact" ]; then
        sudo rm -rf /Build/HolismReact
    fi
    mkdir -p /Build/HolismReact
    cp -r /HolismReact/Infra /Build/HolismReact/Infra
}

function UseProductionCracoBuildConfig()
{
    cp /HolismReact/Infra/CracoProductionConfig /Build/HolismReact/Infra/craco.config.js
}

function ReplaceSymlinksWithOriginalFiles()
{
    find /Build/$Organization/$Repository -type l | 
    while read file; do 
        OriginalPath=$(readlink -f $file)
        echo "$file - $OriginalPath"
        sudo rm -rf $file;
        cp $OriginalPath $file
        sudo chmod 777 $file
    done
}

function BuildReact() {
    echo "Building panel ..."

    CreateHolismReactDirectory
    GetHolismReactInfra

    CopyHolismHoldingInfra
    CopyHolismReactInfra
    CopyDependencies
    CopyRepository
    RemoveGitsDirectory
    UseProductionCracoBuildConfig
    ReplaceSymlinksWithOriginalFiles

    Dockerfile=/Build/Dockerfile
    envsubst < /HolismHolding/Infra/React/Prod/Dockerfile > $Dockerfile
    docker build -f $Dockerfile -t ghcr.io/$LowercaseOrg/$LowercaseRepo:latest /Build
}