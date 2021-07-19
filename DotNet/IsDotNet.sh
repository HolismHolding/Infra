function IsDotNet() {
    sln=$(find "$PWD" -name *.sln|head -n1)
    if [ ! -z "$sln" ]; then
        return 0;
    else 
        return 1;
    fi
}