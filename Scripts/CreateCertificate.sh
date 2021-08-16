function CreateCertificate() {
    # if [ -f "/Temp/$Organization/$Repository/Certificate.pem" ]; then
    #     return;
    # fi
    sudo rm -rf /Temp/$Organization/$Repository/Certificate.pem;
    sudo rm -rf /Temp/$Organization/$Repository/Key.pem
    if [ -z ${Host+x} ]; then
        return;
    fi
    echo "Creating certificate for $Host";
    mkcert -cert-file /Temp/$Organization/$Repository/Certificate.pem -key-file /Temp/$Organization/$Repository/Key.pem $Host 2>/dev/null
    sudo chmod 777 /Temp/$Organization/$Repository/Certificate.pem;
    sudo chmod 777 /Temp/$Organization/$Repository/Key.pem;
}