#!/bin/bash

. /HolismHolding/Infra/Scripts/Message.sh

function LinkSettings()
{
    Info "Linking Settings.json ...";
    sudo ln -s -f /$Organization/Common/Settings.json /$Organization/$Repository/Settings.json
    Divide
}