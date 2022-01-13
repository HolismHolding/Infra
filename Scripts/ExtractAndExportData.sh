. /HolismHolding/Infra/Scripts/Message.sh

function ExtractAndExportData() {
    echo "Directory: " $PWD
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
    fi
    echo "Organization: " $Organization
    echo "Organization Prefix: " $OrganizationPrefix
    echo "Repository: " $Repository
    if [[ $ParentOrganization != "" ]]; then
        Info "Parent Organization: $ParentOrganization"
    fi
}