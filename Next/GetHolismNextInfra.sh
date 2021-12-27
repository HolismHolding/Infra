function GetHolismNextInfra() {
    infraPath=/HolismNext/Infra
    if [ -d "$infraPath" ]; then
        echo "Pulling $infraPath"
        git -C $infraPath pull
    else
        echo "Cloning $infraPath"
        sudo mkdir -p /HolismNext/Infra
        sudo chmod -R 777 /HolismNext
        git -C /HolismNext clone git@github.com:HolismNext/Infra || git -C /HolismNext clone https://github.com/HolismNext/Infra
    fi
    sudo chmod -R 777 /HolismNext
}