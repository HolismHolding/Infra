function GetHolismNextInfra() {
    infraPath=/HolismNext/Infra
    if [ -d "$infraPath" ]; then
        echo "Pulling $infraPath"
        git -C $infraPath pull
    else
        echo "Cloning $infraPath"
        sudo mkdir -p /HolismNext/Infra
        sudo chmod -R 777 /HolismNext
        CurrentDir=$PWD
        cd /HolismNext
        sudo git clone git@github.com:HolismNext/Infra || sudo git clone https://github.com/HolismNext/Infra
        cd $CurrentDir
    fi
    sudo chmod -R 777 /HolismNext
}