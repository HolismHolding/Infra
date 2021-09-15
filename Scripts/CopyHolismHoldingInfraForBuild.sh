function CopyHolismHoldingInfraForBuild() {
    echo "Copying holding base ...";
    if [ -d "/Build/HolismHolding" ]; then
        sudo rm -rf /Build/HolismHolding
    fi
    mkdir -p /Build/HolismHolding
    cp -r /HolismHolding/Infra /Build/HolismHolding/Infra
}