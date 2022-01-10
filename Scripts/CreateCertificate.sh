function CreateCertificate() {
    CertificatePath=/Temp/$Organization/$Repository;
    sudo mkdir -p $CertificatePath
    sudo chmod 777 $CertificatePath
    if [ -z ${Host+x} ]; then
        return;
    fi
    sudo rm -rf $CertificatePath/Certificate.pem;
    sudo rm -rf $CertificatePath/Key.pem
    echo "Creating certificate for $Host";
    mkcert -cert-file $CertificatePath/Certificate.pem -key-file $CertificatePath/Key.pem $Host 2>/dev/null
    sudo chmod 777 $CertificatePath/Certificate.pem;
    sudo chmod 777 $CertificatePath/Key.pem;
}