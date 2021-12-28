. /HolismHolding/Infra/Scripts/Message.sh

function LinkUsings()
{
    Divide
    Info "Linking global usings"
    Divide

    Info "/$Organization/$Repository/Api/Usings.cs"
    sudo ln -s -f /HolismDotNet/Infra/Api/Usings.cs /$Organization/$Repository/Api/Usings.cs

    Info "/$Organization/$Repository/Api/InfraUsings.cs"
    sudo ln -s -f /$Organization/Common/InfraUsings.cs /$Organization/$Repository/Api/InfraUsings.cs

    Info "/$Organization/$Repository/Api/${OrganizationPrefix}Usings.cs"
    sudo ln -s -f /$Organization/Common/${OrganizationPrefix}Usings.cs /$Organization/$Repository/Api/${OrganizationPrefix}Usings.cs

    echo ""

    if [ ! -f "$PWD/Dependencies" ]; then
        return;
    fi
    while read Dependency; do  
        Org=$(echo $Dependency | cut -d'/' -f1)
        Repo=$(echo $Dependency | cut -d'/' -f2)
        if [ -d /$Org/$Repo/Business ]; then
            Info "/$Org/$Repo/Business/Usings.cs"
            sudo ln -s -f /HolismDotNet/Infra/Business/Usings.cs /$Org/$Repo/Business/Usings.cs
        fi
    done <<< "$({ cat "$PWD/Dependencies"; echo; })"

    Divide
}