function GetDependencies() {
    Info "Getting dependencies ...";
    Divide
    if [ ! -f "$PWD/Dependencies" ]; then
        return;
    fi
    while read Dependency; do  
        Org=$(echo $Dependency | cut -d'/' -f1)
        Repo=$(echo $Dependency | cut -d'/' -f2)
        if [ ! -d "/$Org" ]; then
            sudo mkdir "/$Org"
            sudo chmod -R 777 "/$Org"
        fi
        if [ ! -d "/$Org/$Repo" ]; then 
            Info "Cloning /$Org/$Repo ..."
            git -C /$Org clone git@github.com:$Org/$Repo &
        else 
            Info "Pulling /$Org/$Repo ..."
            git -C /$Org/$Repo pull &
        fi
        volumes="$volumes\n            - *$Org*$Repo:*$Org*$Repo"
    done <<< "$({ cat "$PWD/Dependencies"; echo; })"
}
