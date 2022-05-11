function GetHolismHoldingPolicies(){
    policiesPath=/HolismHolding/Policies
    if [ -d $policiesPath ]; then
        echo "Pulling $policiesPath"
        git -C $policiesPath pull
    else
        echo "Cloning $policiesPath"
        git -C /HolismHolding clone git@github.com:HolismHolding/Policies
    fi
}