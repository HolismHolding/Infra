. /HolismHolding/Infra/Scripts/Message.sh

function ExtractAndExportData() {
    Info "Directory: $PWD"
    echo
    export Organization="`dirname $PWD | sed 's/\///g'`"
    if [[ $Organization == *"Holism"* ]]; then
        export OrganizationPrefix="Holism";
    else
        OrganizationPrefix=`echo $Organization | sed 's/Company//g'`
        export OrganizationPrefix=`echo $OrganizationPrefix | sed 's/Product//g'`
    fi
    export Repository="$(basename $PWD)"
    export RepositoryPath=$PWD
    export LowercaseOrg=$(echo $OrganizationPrefix | tr '[:upper:]' '[:lower:]')
    export LowercaseRepo=$(echo $Repository | tr '[:upper:]' '[:lower:]')
    if [ -f /$Organization/Parent ]; then
        export ParentOrganization=$(cat /$Organization/Parent)
        export LowercaseParentOrg=$(echo $ParentOrganization | tr '[:upper:]' '[:lower:]')
    fi
    Success "Organization: $Organization"
    Success "Organization Prefix: $OrganizationPrefix"
    Success "Repository: $Repository"
    if [[ $ParentOrganization != "" ]]; then
        Success "Parent Organization: $ParentOrganization"
    fi
}