#!/bin/bash

. /HolismHolding/Infra/Scripts/Message.sh

function LinkConnectionStrings()
{
    Info "Linking ConnectionStrings.json ...";
    sudo ln -s -f /$Organization/Common/ConnectionStrings.json /$Organization/$Repository/ConnectionStrings.json
    Divide
}