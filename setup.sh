#!/bin/bash

# somehow setup hosts too => https://www.interserver.net/tips/kb/local-domain-names-ubuntu/

echo "running nefcanto setup"
echo "directory is: " $PWD
export Package="$(basename $PWD)"
export PackagePath=$PWD

# package & app = module & host = reusable & runnable

sudo rm -rf /setup

sudo mkdir /setup

if [ -f "App.js" ]; then
    echo "React, panel"
    sudo wget -O /setup/react-panel-compose.yml https://raw.githubusercontent.com/HolismReact/Infra/main/panel-compose.yml
    docker-compose -f /setup/react-panel-compose.yml up
# elif => $PWD ends with App => it's an app|runnable|host
elif [ -f "Resources.js" ]; then
    echo "React, reusable|package|module"
    sudo wget -O /setup/react-reusable-compose.yml https://raw.githubusercontent.com/HolismReact/Infra/main/docker-compose.yml
    docker-compose -f /setup/react-reusable-compose.yml up
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
# sudo echo "alias setup='/nefcanto/infra/setup.sh .'" >> /etc/bash.bashrc