function GetHolismReactInfra() {
    infraPath=/HolismReact/Infra
    if [ -d "$infraPath" ]; then
        echo "Pulling $infraPath"
        git -C $infraPath pull
    else
        sudo mkdir -p /HolismReact
        sudo chmod -R 777 /HolismReact
        echo "Cloning $infraPath"
        git -C /HolismReact clone git@github.com:HolismReact/Infra || git -C /HolismReact clone https://github.com/HolismReact/Infra
    fi
    sudo chmod -R 777 /HolismReact
}