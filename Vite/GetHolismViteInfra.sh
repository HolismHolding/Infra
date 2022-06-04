function GetHolismViteInfra() {
    infraPath=/HolismVite/Infra
    if [ -d "$infraPath" ]; then
        echo "Pulling $infraPath"
        git -C $infraPath pull
    else
        sudo mkdir -p /HolismVite
        sudo chmod -R 777 /HolismVite
        echo "Cloning $infraPath"
        git -C /HolismVite clone git@github.com:HolismVite/Infra || git -C /HolismVite clone https://github.com/HolismVite/Infra
    fi
    sudo chmod -R 777 /HolismVite
}