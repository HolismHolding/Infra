function GetHolismHoldingInfra(){
    infraPath=/HolismHolding/Infra
    echo "Pulling $infraPath"
    git -C $infraPath pull
}