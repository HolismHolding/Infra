#!/bin/bash

. /HolismHolding/Infra/Scripts/Message.sh

function LinkApiSolution()
{
    Info "Linking Api.sln ...";
    sudo ln -s -f /HolismHolding/Infra/DotNet/Api.sln /$Organization/$Repository/$Repository.sln
    Divide
}