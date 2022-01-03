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

    Divide
}