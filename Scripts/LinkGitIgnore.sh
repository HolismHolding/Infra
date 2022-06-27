. /HolismHolding/Infra/Vite/IsVite.sh
. /HolismHolding/Infra/Next/IsNext.sh
. /HolismHolding/Infra/DotNet/IsDotNet.sh
. /HolismHolding/Infra/Scripts/Message.sh

function LinkGitIgnoreForIndependentOrganization()
{
    if [ -f "$Repo/.gitignore" ]; then
        sudo rm -rf "$Repo/.gitignore"
    fi
    if IsNext $Repo; then
        export GitIgnoreSource="/HolismHolding/Infra/Next/Dev/GitIgnore";
    elif IsVite $Repo || [ $(basename $Repo) = 'Common' ]; then
        export GitIgnoreSource="/HolismHolding/Infra/Vite/Dev/GitIgnore";
    elif IsDotNet $Repo; then
        export GitIgnoreSource="/HolismHolding/Infra/DotNet/Dev/GitIgnore";
    else
        export GitIgnoreSource="";
    fi
    if [ -z ${GitIgnoreSource+x} ]; then
        return;
    fi
    if [ ! -d $Repo/.git ]; then
        Warning "$Repo is not a git repository"
        return;
    fi
    Info "Copying .gitignore from $GitIgnoreSource to $Repo/.git/info/exclude"
    cp $GitIgnoreSource "$Repo/.git/info/exclude"
}

function LinkGitIgnoreForChildOrganization()
{
    export ParentRepo=$(dirname $Repo)
    if [ ! -d $ParentRepo/.git ]; then
        Warning "$ParentRepo is not a git repository"
        return
    fi
    echo "" > "$ParentRepo/.git/info/exclude"
    Info "Writing all .gitignores from /HolismHolding to $ParentRepo/.git/info/exclude"
    find /HolismHolding -type f -name GitIgnore | 
    while read ignore; do
        cat $ignore >> "$ParentRepo/.git/info/exclude"
    done
}

function LinkGitIgnore() 
{
    export Repo=$1
    if [[ $ParentOrganization == "" ]]; then
        LinkGitIgnoreForIndependentOrganization
    else
        LinkGitIgnoreForChildOrganization
    fi
}
