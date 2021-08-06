function CleanDocker() {
    echo 'Cleaning Docker, pruning images, networks, containers ...';
    docker container prune --force
    docker image prune --force
    docker network prune --force
}