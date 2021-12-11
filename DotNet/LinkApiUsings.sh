. /HolismHolding/Infra/Scripts/Message.sh

function LinkApiUsings()
{
    Divide
    Info "Linking API Usings.cs"
    Divide

    sudo ln -s -f /HolismDotNet/Infra/Api/Usings.cs /$Organization/$Repository/Api/Usings.cs

    sudo ln -s -f /$Organization/Common/InfraUsings.cs /$Organization/$Repository/Api/InfraUsings.cs

    sudo ln -s -f /$Organization/Common/${OrganizationPrefix}Usings.cs /$Organization/$Repository/Api/${OrganizationPrefix}Usings.cs
}