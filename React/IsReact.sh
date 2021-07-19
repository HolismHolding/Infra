function IsReact() {
    if IsReactSite $1 || IsReactPanel $1; then
        return 0
    else
        return 1
    fi
}