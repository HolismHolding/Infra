#!/bin/bash

. /Nefcanto/Infra/React/Setup.sh

# somehow setup hosts too => https://www.interserver.net/tips/kb/local-domain-names-ubuntu/

echo "running nefcanto setup"
echo "directory is: " $PWD
export Reusable="$(basename $PWD)"
export Runnable="$(basename $PWD)"
export ReusablePath=$PWD
export RunnablePath=$PWD

# package & app = module & host = reusable & runnable

function GetHoldingInfra(){
    infraPath=/Nefcanto/Infra
    echo "Pulling $infraPath"
    git -C $infraPath pull
}

GetHoldingInfra

if [ IsReact ]; then
    SetupReact
elif [ -f "${Reusable}.sln" ]; then
    echo ".NET runnable|host|app"
    sudo wget -O /setup/DotNetDevRunnable.yml https://raw.githubusercontent.com/Nefcanto/Infra/main/DotNet/Dev/Runnable
    docker-compose -f /setup/DotNetDevRunnable.yml up
elif [ -f "composer.json" ]; then
    echo "Laravel, reusable|package|module"
elif [ -f ".env" ]; then
    echoe "Laravel, runnable|host|app"
elif [ -f "package.json" ]; then
    echo "React, runnable"
else
    echo "None"
fi

# register it globally
# sudo chmod u+rw /etc/bash.bashrc
# sudo echo "alias setup='/Nefcanto/Infra/Setup.sh .'" >> /etc/bash.bashrc