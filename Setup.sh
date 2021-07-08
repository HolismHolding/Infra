#!/bin/bash

. /HolismHolding/Infra/React/Setup.sh
. /HolismHolding/Infra/DotNet/Setup.sh
. /HolismHolding/Infra/Laravel/Setup.sh

# somehow setup hosts too => https://www.interserver.net/tips/kb/local-domain-names-ubuntu/
# sudo chmod u+rw /etc/hosts
# sudo echo "127.0.0.1 domain.local" >> /etc/hosts
# if folder contains "Sites" then we can use it, otherwise we can create domains by convention, for example api.geo.local

echo "Holding setup"
echo "Directory: " $PWD
export Organization="`dirname $PWD | sed 's/\///g'`"
if [[ $Organization == *"Holism"* ]]; then
    export OrganizationPrefix="Holism";
else
    OrganizationPrefix=`echo $Organization | sed 's/Company//g'`
    export OrganizationPrefix=`echo $OrganizationPrefix | sed 's/Product//g'`
fi
export Repository="$(basename $PWD)"
export RepositoryPath=$PWD
echo "Organization: " $Organization
echo "Organization Prefix: " $OrganizationPrefix
echo "Repository: " $Repository

# package & app = module & host = reusable & runnable

function MakeSureTempDirectoryExists() {
    if [ ! -d "/Temp" ]; then
        sudo mkdir /Temp
    fi
    permissions=$(stat /Temp | grep -oP "(?<=Access: \()[^)]*")
    if [  $permissions = "0777/drwxrwxrwx" ]; then
        echo '/Temp folder has full access'
    else 
        sudo chmod -R 777 /Temp
    fi 
}

function GetHoldingInfra(){
    infraPath=/HolismHolding/Infra
    echo "Pulling $infraPath"
    git -C $infraPath pull
}

MakeSureTempDirectoryExists
GetHoldingInfra

if IsReact $1; then
    SetupReact
elif IsDotNet $1; then
    SetupDotNet
elif IsLaravel $1; then
    SetupLaravel
# elif IsPython $1; then
#     SetupPython
# elif IsNode $1; then
#     SetupNode
# elif IsAngular $1; then
#     SetupAngular
else
    echo "Project type = Unknown"
fi

# register it globally
# sudo chmod u+rw /etc/bash.bashrc
# sudo echo "alias setup='/HolismHolding/Infra/Setup.sh .'" >> /etc/bash.bashrc