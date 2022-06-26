. /HolismHolding/Infra/React/IsReact.sh
. /HolismHolding/Infra/Vite/IsVite.sh
. /HolismHolding/Infra/Next/IsNext.sh
. /HolismHolding/Infra/DotNet/IsDotNet.sh
. /HolismHolding/Infra/Scripts/Message.sh

function LinkGitIgnore() {
    if [ -f "$1/.gitignore" ]; then
        sudo rm -rf "$1/.gitignore"
    fi
    if IsNext $1; then
        export GitIgnoreSource="/HolismHolding/Infra/Next/Dev/GitIgnore";
    elif IsVite $1; then
        export GitIgnoreSource="/HolismHolding/Infra/Vite/Dev/GitIgnore";
    elif IsReact $1 || [ $(basename $1) = 'Common' ]; then
        export GitIgnoreSource="/HolismHolding/Infra/React/Dev/GitIgnore";
    elif IsDotNet $1; then
        export GitIgnoreSource="/HolismHolding/Infra/DotNet/Dev/GitIgnore";
    else
        export GitIgnoreSource="";
    fi
    if [ -z ${GitIgnoreSource+x} ]; then
        return;
    fi
    if [[ $ParentOrganization == "" ]]; then
        if [ ! -d $1/.git ]; then
            Warning "$1 is not a git repository"
            return;
        fi
    else
        if [ ! -d $(dirname $1) ]; then
            Warning "$(dirname $1) is not a git repository"
            return
        fi
        Info "Copying .gitignore from $GitIgnoreSource to $(dirname $1)/.git/info/exclude"
        cp $GitIgnoreSource "$(dirname $1)/.git/info/exclude"
    fi
}
