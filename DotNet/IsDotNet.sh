function IsDotNet() {
    sln=$(find "$PWD" -maxdepth 1 -name *.sln|head -n1)
    csproj=$(find "$PWD" -maxdepth 1 -name *.csproj|head -n1)
    settings=$(find "$PWD" -maxdepth 1 -name Settings.json|head -n1)
    if [ ! -z "$sln" ] || [ ! -z "$csproj" ] || [ ! -z "$settings" ]; then
        return 0;
    else 
        return 1;
    fi
}