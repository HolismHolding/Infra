. /HolismHolding/Infra/Next/CreateHolismNextDirectory.sh
. /HolismHolding/Infra/Next/GetHolismNextInfra.sh
. /HolismHolding/Infra/Scripts/LinkGitIgnore.sh
. /HolismHolding/Infra/Next/DetermineTailwindConfigPath.sh
. /HolismHolding/Infra/Scripts/CreateGitHubAction.sh
. /HolismHolding/Infra/Scripts/Message.sh

function PullNextDevDockerImage() {
    Info 'Pulling docker image holism/next-dev:latest'
    docker pull holism/next-dev:latest
}

function CreateBuildDirectory() {
    if [ ! -d "/Temp$RepositoryPath/Build" ]; then
        Info "Creating directory: /Temp$RepositoryPath/Build";
        sudo mkdir "/Temp$RepositoryPath/Build";
        sudo chmod -R 777 "/Temp$RepositoryPath/Build";
    fi
}

function SetupNext() {
    Info "Seting up site"
    CreateHolismNextDirectory
    GetHolismNextInfra &
    LinkGitIgnore $PWD
    PullNextDevDockerImage &
    CreateGitHubAction Next
    DetermineTailwindConfigPath
    ComposeFile=/Temp/$Organization/$Repository/DockerCompose.yml
    mkdir -p $(dirname $ComposeFile)
    CreateBuildDirectory
    envsubst < /HolismHolding/Infra/Next/Dev/DockerCompose.yml > $ComposeFile
    docker-compose -p "${Organization}_${Repository}" -f $ComposeFile up --remove-orphans
}