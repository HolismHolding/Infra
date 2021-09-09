function IsDotNet() {
    sln=$(find "$PWD" -name *.sln|head -n1)
    csproj=$(find "$PWD" -name *.csproj|head -n1)
    if [ ! -z "$sln" ] || [ ! -z "$csproj" ]; then
        return 0;
    else 
        return 1;
    fi
}