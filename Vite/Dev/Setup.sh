. /HolismHolding/Infra/Vite/CreateHolismViteDirectory.sh
. /HolismHolding/Infra/Vite/GetHolismViteInfra.sh
. /HolismHolding/Infra/Scripts/LinkGitIgnore.sh
. /HolismHolding/Infra/Scripts/CreateGitHubAction.sh

function PullViteDockerImage() {
    echo 'Pulling docker image holism/vite-dev:latest'
    docker pull holism/vite-dev:latest
}

function CreateBuildDirectory() {
    if [ ! -d "/Temp$RepositoryPath/Build" ]; then
        echo "Creating directory: /Temp$RepositoryPath/Build";
        sudo mkdir "/Temp$RepositoryPath/Build";
        sudo chmod -R 777 "/Temp$RepositoryPath/Build";
    fi
}

function BuildMappings()
{
    while read Item; do
        ReplacedItem=${Item#./}
        if [ $ReplacedItem == .gitignore ] || [ $ReplacedItem == .github ] || [ $ReplacedItem == Dependencies ] || [ $ReplacedItem == . ]; then
            continue
        fi
        export volumes="$volumes\n            - *$Organization*$Repository*$ReplacedItem:*$Organization*$Repository*src*$ReplacedItem"
    done <<< "$(find . -maxdepth 1 -type l -or -type d | sort)"
}

function SetupVite() {
    CreateHolismViteDirectory
    # GetHolismViteInfra &
    # PullViteDockerImage
    LinkGitIgnore $PWD
    CreateGitHubAction Vite
    export volumes=""
    GetDependencies
    BuildMappings
    echo -e $volumes

    ComposePath=/Temp/$Organization/$Repository/DockerCompose.yml
    mkdir -p $(dirname $ComposePath)
    CreateBuildDirectory
    envsubst < /HolismHolding/Infra/Vite/Dev/DockerCompose.yml > $ComposePath
    sed -i "s/DependenciesMappingPlaceHolder/$volumes/g" $ComposePath
    sed -i "s/*/\//g" $ComposePath
    echo "Using docker-compose file => $ComposePath"
    docker-compose -p "${Organization}_${Repository}" -f $ComposePath up --remove-orphans
}