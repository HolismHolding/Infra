#!/bin/bash

# somehow setup hosts too => https://www.interserver.net/tips/kb/local-domain-names-ubuntu/

echo "running nefcanto setup"
echo "directory is: " $PWD
export Reusable="$(basename $PWD)"
export Runnable="$(basename $PWD)"
export ReusablePath=$PWD
export RunnablePath=$PWD

# package & app = module & host = reusable & runnable

sudo rm -rf /setup

sudo mkdir /setup

if [ -f "App.js" ]; then
    echo "React, panel"
    sudo wget -O /setup/ReactDevPanel.yml https://raw.githubusercontent.com/Nefcanto/Infra/main/React/Dev/Panel
    docker-compose -f /setup/ReactDevPanel.yml up
# elif => $PWD ends with App => it's an app|runnable|host
elif [ -f "Resources.js" ]; then
    if [ -f ".env" ]; then
        echo "React, runnable|host|app"
        docker-compose -f /nefcanto/react-dev-runnable-docker-compose.yml up
    else
        echo "React, reusable|module|package"
        sudo wget -O /setup/react-reusable-compose.yml https://raw.githubusercontent.com/HolismReact/Infra/main/docker-compose.yml
        docker-compose -f /setup/react-reusable-compose.yml up
    fi
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