function CreateCertificate() {
    if [ -f "/Temp/$Organization/$Repository/Certificate.pem" ]; then
        return;
    fi
    if [ -z ${Host+x} ]; then
        return;
    fi
    echo "Creating certificate for $Host";
    mkcert -cert-file /Temp/$Organization/$Repository/Certificate.pem -key-file /Temp/$Organization/$Repository/Key.pem $Host 2>/dev/null
}