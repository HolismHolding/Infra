. /HolismHolding/Infra/Scripts/Message.sh

function CreateCertificate() {
    CertificatePath=/Temp/$Organization/$Repository;
    sudo mkdir -p $CertificatePath
    sudo chmod 777 $CertificatePath
    if [[ $Repository != "Databases" ]] && [ ! -f /$Organization/$Repository/Host ]; then
        Error "Host file does not exist in /$Organization/$Repository";
        exit;
    fi
    if [ -z ${Host+x} ]; then
        return;
    fi
    sudo rm -rf $CertificatePath/Certificate.pem;
    sudo rm -rf $CertificatePath/Key.pem
    Info "Creating certificate for $Host";
    sudo mkcert -cert-file $CertificatePath/Certificate.pem -key-file $CertificatePath/Key.pem $Host 2>/dev/null
    sudo chmod 777 $CertificatePath/Certificate.pem;
    sudo chmod 777 $CertificatePath/Key.pem;
}