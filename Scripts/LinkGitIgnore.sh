. /HolismHolding/Infra/React/IsReact.sh

function LinkGitIgnore() {
    if [ -f "$1/.gitignore" ]; then
        #echo "Removing old .gitignore ...";
        sudo rm -rf "$1/.gitignore"
    fi
    if IsNext $1; then
        export GitIgnoreSource="/HolismHolding/Infra/Next/Dev/GitIgnore";
    elif IsReact $1; then
        export GitIgnoreSource="/HolismHolding/Infra/React/Dev/GitIgnore";
    elif IsDotNet $1; then
        export GitIgnoreSource="/HolismHolding/Infra/DotNet/Dev/GitIgnore";
    else
        export GitIgnoreSource="";
    fi
    if [ -z ${GitIgnoreSource+x} ]; then
        return;
    fi
    # echo "Creating .gitignore link to $GitIgnoreSource for $1 ...";
    sudo ln -s $GitIgnoreSource "$1/.gitignore"
}
