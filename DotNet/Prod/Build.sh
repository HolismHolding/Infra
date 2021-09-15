. /HolismHolding/Infra/Scripts/CopyHolismHoldingInfraForBuild.sh

function CopyDotNetBase() {
    echo "Copying dot net base ...";
    mkdir /Build/HolismDotNet
    cp -r /HolismDotNet/Infra /Build/HolismDotNet/Infra
    cp -r /HolismDotNet/Accounts /Build/HolismDotNet/Accounts
}

function CopyDependencies() {    
    echo "Copying dependencies ...";
    if [ ! -f "$PWD/Dependencies" ]; then
        return;
    fi
    input="$PWD/Dependencies"
    while IFS= read -r line || [ -n "$line" ]
        do
            Org=$(echo $line | cut -d'/' -f1)
            if [ ! -d "/Build/$Org" ]; then
                mkdir /Build/$Org
            fi
            echo "Copying /$line";
            cp -r /$line /Build/$line
        done < "$input"
}

function CopyRepository() {
    echo "Copying repository ..."
    Org=$(echo $PWD | cut -d'/' -f2)
    if [ ! -d "/Build/$Org" ]; then
        mkdir /Build/$Org
    fi
    cp -r $PWD /Build$PWD
}

function RemoveBinsAndObjs() {
    echo "Removing bin and obj directories ..."
    find /Build -type d -name "bin" | xargs sudo rm -rf
    find /Build -type d -name "obj" | xargs sudo rm -rf
}

function RemvoeGits() {
    echo "Removing .git directories"
    find /Build -type d -name ".git" | xargs sudo rm -rf
}

function CopyDockerFile() {
    export Dockerfile=/Build/Dockerfile
    envsubst < /HolismHolding/Infra/DotNet/Prod/Dockerfile > $Dockerfile
}

function BuildImage() {
    docker build -f $Dockerfile -t ghcr.io/$LowercaseOrg/$LowercaseRepo:latest /Build
}

function BuildDotNet() {
    CopyHolismHoldingInfraForBuild
    CopyDotNetBase
    CopyDependencies
    CopyRepository
    RemoveBinsAndObjs
    RemvoeGits
    CopyDockerFile
    BuildImage
}