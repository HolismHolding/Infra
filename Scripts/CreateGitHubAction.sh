function GetActionSnippet()
{
    Org=$1
    Repo=$2
    Yaml=$(cat /HolismHolding/Infra/GetRepositoryAction.yml)
    ActionSnippet=$(envsubst <<< "$Yaml")
}

function GetDependenciesActions()
{
    echo "Getting dependencies actions";
    if [ ! -f "$PWD/Dependencies" ]; then
        return;
    fi
    while read Dependency; do  
        
        export Org=$(echo $Dependency | cut -d'/' -f1)
        export Repo=$(echo $Dependency | cut -d'/' -f2)

        if [[ $Org == $Organization ]] && [[ $ParentOrganization != "" ]]; then
            continue
        fi

        GetActionSnippet $Org $Repo

        DependencyActions="$DependencyActions\n\n$ActionSnippet"

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

    echo -e "${Temp/GettingDependencyRepositoriesPlacholder/"$DependencyActions"}" > $GitHubActionPath


    if [[ $ParentOrganization == "" ]]; then
        Org=$Organization
        Repo=$Repository
    else
        Org=$ParentOrganization
        Repo=$Organization
    fi
    GetActionSnippet $Org $Repo
    ActionSnippet="\n$ActionSnippet"

    if [[ $ParentOrganization != "" ]]; then
        CopyYml=$(cat /HolismHolding/Infra/CopyParentToMain.yml)
        CopySnippet=$(envsubst <<< "$CopyYml")
        ActionSnippet="$ActionSnippet$CopySnippet"
    fi

    Temp=$(cat $GitHubActionPath)
    echo -e "${Temp/GettingMainRepositoryPlaceholder/"$ActionSnippet"}" > $GitHubActionPath

    CopyTarget=/$Organization/.github/workflows/$Repository.yml
    sudo cp $GitHubActionPath $CopyTarget
    sudo sed -i "s/^name:.*$/name: $Repository/g" $CopyTarget

    echo "Created GitHub action"
}