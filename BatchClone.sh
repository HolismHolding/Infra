organization=$(basename $PWD)

echo "Organization: $organization"

curl https://api.github.com/orgs/$organization/repos?type=all | grep full_name | while read -r line ; do
    echo "Processing $line"
    echo ${(grep "$line" name)}
done