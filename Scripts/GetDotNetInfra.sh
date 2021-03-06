function GetDotNetInfra() {
    infraPath=/HolismDotNet/Infra
    if [ -d "$infraPath" ]; then
        echo "Pulling $infraPath"
        git -C $infraPath pull
    else
        sudo mkdir -p /HolismDotNet
        sudo chmod -R 777 /HolismDotNet
        echo "Cloning $infraPath"
        git -C /HolismDotNet clone git@github.com:HolismDotNet/Infra
    fi
    sudo chmod -R 777 /HolismDotNet
}
