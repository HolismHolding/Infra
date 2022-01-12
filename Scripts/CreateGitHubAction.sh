function GetDependenciesActions()
{
    echo "Getting dependencies actions";
    if [ ! -f "$PWD/Dependencies" ]; then
        return;
    fi
    while read Dependency; do  
        
        export Org=$(echo $Dependency | cut -d'/' -f1)
        export Repo=$(echo $Dependency | cut -d'/' -f2)

        Yaml=$(cat /HolismHolding/Infra/GetRepositoryAction.yml)
        DependencyAction=$(envsubst <<< "$Yaml")

        DependencyActions="$DependencyActions\n\n$DependencyAction"

    done <<< "$({ cat "$PWD/Dependencies"; echo; })"
}

function CreateGitHubAction()
{
    GitHubActionPath=/$Organization/$Repository/.github/workflows/BuildAndPushDockerImage.yml
    mkdir -p $(dirname $GitHubActionPath)
    export GITHUB_WORKSPACE="$""GITHUB_WORKSPACE"

    DependencyActions=""
    GetDependenciesActions DependencyActions

    envsubst < /HolismHolding/Infra/$1/GitHubAction.yml > $GitHubActionPath
    Temp=$(cat $GitHubActionPath)

    echo -e "${Temp/GettingDependenciesRepositoriesPlacholder/"$DependencyActions"}" > $GitHubActionPath

    CopyTarget=/$Organization/.github/workflows/$Repository.yml
    sudo cp $GitHubActionPath $CopyTarget
    sudo sed -i "s/name:.*$/name: $Repository/g" $CopyTarget

    echo "Created GitHub action"
}