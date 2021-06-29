#!/bin/bash

. /Nefcanto/Infra/React/Setup.sh
. /Nefcanto/Infra/DotNet/Setup.sh

# somehow setup hosts too => https://www.interserver.net/tips/kb/local-domain-names-ubuntu/

echo "Nefcanto setup"
echo "directory: " $PWD
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

if IsReact $1; then
    SetupReact
elif IsDotNet $1; then
    SetupDotNet
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