echo "Path inside container is: $PWD"

echo 'alias run="/HolismHolding/Infra/DotNet/Dev/Run.sh"' >> /etc/profile
echo 'alias run="/HolismHolding/Infra/DotNet/Dev/Run.sh"' >> ~/.profile
echo 'alias run="/HolismHolding/Infra/DotNet/Dev/Run.sh"' >> ~/.bashrc

echo 'ENV=/HolismHolding/Infra/DotNet/Dev/Run.sh; export ENV' >> ~/.profile

for i in {1..50};
do
    if [ $? -eq 0 ]
    then
        echo "SQL Server is ready"
        if [ -f "/$RepositoryPath/SetupDatabase.sh" ]; then
            /$RepositoryPath/SetupDatabase.sh
        else
            dotnet ef database update --project DataAccess
        fi
        break
    else
        echo "Waiting for SQL Server..."
        sleep 1
    fi
done