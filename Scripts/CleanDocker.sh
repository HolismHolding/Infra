function CleanDocker() {
    Divide
    Info 'Cleaning Docker, pruning images, networks, containers ...';
    docker container prune --force 1>/dev/null
    docker image prune --force 1>/dev/null
    docker network prune --force 1>/dev/null
    Info 'Cleaned Docker'
    Divide
}