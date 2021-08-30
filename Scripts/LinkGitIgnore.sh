function LinkGitIgnore() {
    if [ -f "$1/.gitignore" ]; then
        sudo rm -rf "$1/.gitignore"
    fi
    sudo ln -s /HolismHolding/Infra/DotNet/Dev/GitIgnore "$1/.gitignore"
}
