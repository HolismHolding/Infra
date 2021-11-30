. /HolismHolding/Infra/Scripts/Message.sh

function CopyHolismHoldingInfra() {
    Info "Copying HolismHolding/Infra ...";
    if [ -d "/Build/HolismHolding" ]; then
        sudo rm -rf /Build/HolismHolding
    fi
    mkdir -p /Build/HolismHolding
    cp -r /HolismHolding/Infra /Build/HolismHolding/Infra
}