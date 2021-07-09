. /HolismHolding/Infra/ExtractAndExportData.sh

sudo rm -rf /Temp/Build
mkdir /Temp/Build

function CopyHoldingBase() {
    echo "Copying holding base ...";
    mkdir /Temp/Build/HolismHolding
    cp -r /HolismHolding/Infra /Temp/Build/HolismHolding/Infra
}

function CopyDotNetBase() {
    echo "Copying dot net base ...";
    mkdir /Temp/Build/HolismDotNet
    cp -r /HolismDotNet/Framework /Temp/Build/HolismDotNet/Framework
    cp -r /HolismDotNet/Accounts /Temp/Build/HolismDotNet/Accounts
}

function CopyDependencies() {    
    echo "Copying dependencies ...";
    if [ ! -f "$PWD/Dependencies" ]; then
        return;
    fi
    input="$PWD/Dependencies"
    while IFS= read -r line
        do
            Org=$(echo $line | cut -d'/' -f1)
            if [ ! -d "/Temp/Build/$Org" ]; then
                mkdir /Temp/Build/$Org
            fi
            echo "Copying /$line";
            cp -r /$line /Temp/Build/$line
        done < "$input"
}

function CopyRepository() {
    echo "Copying repository ..."
    Org=$(echo $PWD | cut -d'/' -f2)
    if [ ! -d "/Temp/Build/$Org" ]; then
        mkdir /Temp/Build/$Org
    fi
    cp -r $PWD /Temp/Build$PWD
}

function RemoveBinsAndObjs() {
    echo "Removing bin and obj directories ..."
    find /Temp/Build -type d -name "bin" | xargs sudo rm -rf
    find /Temp/Build -type d -name "obj" | xargs sudo rm -rf
}

function RemvoeGits() {
    echo "Removing .git directories"
    find /Temp/Build -type d -name ".git" | xargs sudo rm -rf
}

function CopyDockerFile() {
    cp /HolismHolding/Infra/DotNet/Prod/Dockerfile /Temp/Build/Dockerfile
}

function BuildImage() {
    lowercaseOrg=$(echo $OrganizationPrefix | tr '[:upper:]' '[:lower:]')
    lowercaseRepo=$(echo $Repository | tr '[:upper:]' '[:lower:]')
    docker build -f /Temp/Build/Dockerfile --build-arg Path=$PWD -t $lowercaseOrg/$lowercaseRepo /Temp/Build
}

ExtractAndExportData
CopyHoldingBase
CopyDotNetBase
CopyDependencies
CopyRepository
RemoveBinsAndObjs
RemvoeGits
CopyDockerFile
BuildImage