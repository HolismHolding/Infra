function LinkGitIgnore() {
    if [ -f "$PWD/.gitignore" ]; then
        sudo rm -rf "$PWD/.gitignore"
    fi
    sudo ln -s /HolismHolding/Infra/DotNet/Dev/GitIgnore "$PWD/.gitignore"
}
