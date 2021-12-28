function GetHolismNodeInfra() {
    infraPath=/HolismNode/Infra
    if [ -d "$infraPath" ]; then
        echo "Pulling $infraPath"
        git -C $infraPath pull
    else
        echo "Cloning $infraPath"
        sudo mkdir -p /HolismNode/Infra
        sudo chmod -R 777 /HolismNode
        CurrentDir=$PWD
        cd /HolismNode
        sudo git clone git@github.com:HolismNode/Infra || sudo git clone https://github.com/HolismNode/Infra
        cd $CurrentDir
    fi
    sudo chmod -R 777 /HolismNode
}