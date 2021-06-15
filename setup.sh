#!/bin/bash

echo "running setup from /nefcanto/infra"
echo "directory is: " $PWD

docker-compose -f /nefcanto/infra/docker-compose.yml build $PWD
docker-compose up -d
docker-compose logs --f db

# make it executable
# sudo chmod +x /nefcanto/infra/setup.sh"

# then register it globally
# sudo echo "alias setup='/nefcanto/infra/setup.sh .'" >> /etc/bash.bashrc