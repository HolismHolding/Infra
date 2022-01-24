#!/bin/bash

. /HolismHolding/Infra/Scripts/Message.sh

function LinkApiCsproj()
{
    Info "Linking Api.csproj ...";
    sudo ln -s -f /HolismHolding/Infra/DotNet/Api.csproj /$Organization/$Repository/Api/Api.csproj
    Divide
}