. /HolismHolding/Infra/Scripts/Message.sh

function LinkApiDependencies()
{
    Info "Linking Dependencies"

    sudo ln -s -f /$Organization/Common/ApiDependencies /$Organization/$Repository/Dependencies

    Divide
}