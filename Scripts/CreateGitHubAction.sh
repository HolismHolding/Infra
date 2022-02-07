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
        export Org=$Organization
        export Repo=$Repository
    else
        export Org=$ParentOrganization
        export Repo=$Organization
    fi
    GetActionSnippet $Org $Repo
    ActionSnippet="\n$ActionSnippet"

    if [[ $ParentOrganization != "" ]]; then
        MoveYml=$(cat /HolismHolding/Infra/MoveMainRepository.yml)
        MoveSnippet=$(envsubst <<< "$MoveYml")
        ActionSnippet="$ActionSnippet$MoveSnippet"
    fi

    Temp=$(cat $GitHubActionPath)
    echo -e "${Temp/GettingMainRepositoryPlaceholder/"$ActionSnippet"}" > $GitHubActionPath

    BuildLoginPushLogoutYml=$(cat /HolismHolding/Infra/BuildLoginPushLogout.yml)
    BuidlLoginPushLogoutSnippet=$(envsubst <<< "$BuildLoginPushLogoutYml")
    Temp=$(cat $GitHubActionPath)
    echo -e "${Temp/BuildLoginPushLogout/"$BuidlLoginPushLogoutSnippet"}" > $GitHubActionPath

    DockerImageName=${LowercaseOrg}/${LowercaseRepo}
    if [[ $ParentOrganization != "" ]]; then
        DockerImageName=$LowercaseParentOrg/${LowercaseOrg}/${LowercaseRepo}
    fi
    echo $DockerImageName
    Temp=$(cat $GitHubActionPath)
    echo -e "${Temp/DockerImageNamePlaceHolder/"$DockerImageName"}" > $GitHubActionPath

    CopyTarget=/$Organization/.github/workflows/$Repository.yml
    if [[ $ParentOrganization != "" ]] && [ ! -d /$Organization/.githb ]; 
    then
        sudo mkdir -p /$Organization/.github/workflows
        sudo chmod -R 777 /$Organization/.github
    fi
    sudo cp $GitHubActionPath $CopyTarget
    sudo sed -i "s/^name:.*$/name: $Repository/g" $CopyTarget

    echo "Created GitHub action"
}