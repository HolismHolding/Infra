#!/bin/bash

# somehow setup hosts too => https://www.interserver.net/tips/kb/local-domain-names-ubuntu/

echo "running setup from /nefcanto/infra"
echo "directory is: " $PWD

export Package="$(basename $PWD)"

# package & app = module & host = reusable & runnable

sudo rm -rf /setup

sudo mkdir /setup

if [ -f "Routes.js" ]; then
    echo "React, reusable"
    sudo wget -O /setup/docker-compose.yml https://raw.githubusercontent.com/HolismReact/Infra/main/docker-compose.yml
    docker-compose -f /setup/docker-compose.yml up
elif [ -f "composer.json" ]; then
    echo "Laravel, reusable"
elif [ -f ".env" ]; then
    echoe "Laravel, runnable"
elif [ -f "package.json" ]; then
    echo "React, runnable"
else
    echo "None"
fi

# make it executable
# sudo chmod +x /nefcanto/infra/setup.sh"

# then register it globally
# sudo chmod -R 777 /etc/bash.bashrc
# sudo echo "alias setup='/nefcanto/infra/setup.sh .'" >> /etc/bash.bashrc