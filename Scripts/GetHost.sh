function GetHost() {
    if [ ! -f "/$Organization/$Repository/Host" ]; then
        return;
    fi
    read Host < /$Organization/$Repository/Host;
    export Host;
    echo "Host is $Host";
}