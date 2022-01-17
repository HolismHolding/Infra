. /HolismHolding/Infra/React/CreateHolismReactDirectory.sh
. /HolismHolding/Infra/React/GetHolismReactInfra.sh
. /HolismHolding/Infra/Scripts/CopyHolismHoldingInfra.sh
. /HolismHolding/Infra/Scripts/CopyDependencies.sh
. /HolismHolding/Infra/Scripts/CopyRepository.sh
. /HolismHolding/Infra/Scripts/RemoveGitsDirectory.sh
. /HolismHolding/Infra/Scripts/Message.sh

function CopyHolismReactInfra() {
    Info "Copying HolismReact/Infra ...";
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
    Info "Replacing symlinks with the original files ..."
    echo
    find /Build/$Organization/$Repository -type l | 
    while read file; do 
        OriginalPath=$(readlink -f $file)
        Info "$file - $OriginalPath"
        sudo rm -rf $file;
        cp -r $OriginalPath $file
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
    Divide
    ReplaceSymlinksWithOriginalFiles
    Divide

    envsubst < /HolismHolding/Infra/React/Prod/Dockerfile > $Dockerfile
}