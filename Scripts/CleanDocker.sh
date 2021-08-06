function CleanDocker() {
    echo 'Cleaning Docker, pruning images, networks, containers ...'
    docker container prune -y
    docker image prune -y
    docker network prune -y
}