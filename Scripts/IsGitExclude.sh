function IsGitExclude () {
    if [[ $1 == *"/Temp/"* ]]; then
        return 0;
    fi
    if [[ $1 == *"/Trash/"* ]]; then
        return 0;
    fi
    if [[ $1 == *"/opt/"* ]]; then
        return 0;
    fi
    return 1;
}