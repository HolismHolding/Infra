. /HolismHolding/Infra/Vite/CreateHolismViteDirectory.sh
. /HolismHolding/Infra/Vite/GetHolismViteInfra.sh
. /HolismHolding/Infra/Scripts/CopyHolismHoldingInfra.sh
. /HolismHolding/Infra/Scripts/CopyDependencies.sh
. /HolismHolding/Infra/Scripts/CopyRepository.sh
. /HolismHolding/Infra/Scripts/RemoveGitsDirectory.sh
. /HolismHolding/Infra/Scripts/Message.sh

function CopyHolismViteInfra() {
    Info "Copying HolismVite/Infra ...";
    if [ -d "/Build/HolismVite" ]; then
        sudo rm -rf /Build/HolismVite
    fi
    mkdir -p /Build/HolismVite
    cp -r /HolismVite/Infra /Build/HolismVite/Infra
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

function BuildVite() {
    echo "Building panel ..."

    CreateHolismViteDirectory
    GetHolismViteInfra

    CopyHolismHoldingInfra
    CopyHolismViteInfra
    CopyDependencies
    CopyRepository
    RemoveGitsDirectory
    Divide
    ReplaceSymlinksWithOriginalFiles
    Divide
    ReplaceSymlinksWithOriginalFiles
    Divide

    envsubst < /HolismHolding/Infra/Vite/Prod/Dockerfile > $Dockerfile
}