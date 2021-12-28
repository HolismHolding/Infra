. /HolismHolding/Infra/Node/CreateHolismNodeDirectory.sh
. /HolismHolding/Infra/Node/GetHolismNodeInfra.sh
. /HolismHolding/Infra/Scripts/LinkGitIgnore.sh

function PullNodeDevDockerImage() {
    echo 'Pulling docker image holism/node-dev:latest'
    docker pull holism/node-dev:latest
}

function CreateGitHubActionForNode() {
    GitHubActionPath=/$Organization/$Repository/.github/workflows/BuildAndPushDockerImage.yml
    mkdir -p $(dirname $GitHubActionPath)
    export GITHUB_WORKSPACE="$""GITHUB_WORKSPACE"
    envsubst < /HolismHolding/Infra/Node/GitHubAction.yml > $GitHubActionPath
    echo "Created GitHub action"
}

function SetupNode() {
    echo "Seting up Node API"
    CreateHolismNodeDirectory
    GetHolismNodeInfra &
    LinkGitIgnore $PWD
    PullNodeDevDockerImage &
    CreateGitHubActionForNode
    ComposeFile=/Temp/$Organization/$Repository/DockerCompose.yml
    mkdir -p $(dirname $ComposeFile)
    envsubst < /HolismHolding/Infra/Node/Dev/DockerCompose.yml > $ComposeFile
    docker-compose -p "${Organization}_${Repository}" -f $ComposeFile up --remove-orphans
}