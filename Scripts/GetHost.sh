function GetHost() {
    if [ ! -f "/$Organization/$Repository/Host" ]; then
        return;
    fi
    read Host < /$Organization/$Repository/Host;
    export Host;
    Info "Host is $Host";
}