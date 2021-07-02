#!/bin/bash

. /Nefcanto/Infra/React/Setup.sh
. /Nefcanto/Infra/DotNet/Setup.sh
. /Nefcanto/Infra/Laravel/Setup.sh

# somehow setup hosts too => https://www.interserver.net/tips/kb/local-domain-names-ubuntu/
# sudo chmod u+rw /etc/hosts
# sudo echo "127.0.0.1 domain.local" >> /etc/hosts
# if folder contains "Sites" then we can use it, otherwise we can create domains by convention, for example api.geo.local

echo "Nefcanto setup"
echo "Directory: " $PWD
export Organization="`dirname $PWD | sed 's/\///g'`"
export OrganizationPrefix=`echo $Organization | sed 's/Holism//g' | sed 's/Company//g'`
export Repository="$(basename $PWD)"
export RepositoryPath=$PWD
echo "Organization: " $Organization
echo "Organization Prefix: " $OrganizationPrefix
echo "Repository: " $Repository

# package & app = module & host = reusable & runnable

function GetHoldingInfra(){
    infraPath=/Nefcanto/Infra
    echo "Pulling $infraPath"
    git -C $infraPath pull
}

GetHoldingInfra

if IsReact $1; then
    SetupReact
elif IsDotNet $1; then
    SetupDotNet
elif IsLaravel $1; then
    SetupLaravel
# elif IsPython $1; then
#     SetupPython
# elif IsNode $1; then
#     SetupNode
# elif IsAngular $1; then
#     SetupAngular
else
    echo "None"
fi

# register it globally
# sudo chmod u+rw /etc/bash.bashrc
# sudo echo "alias setup='/Nefcanto/Infra/Setup.sh .'" >> /etc/bash.bashrc