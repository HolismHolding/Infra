echo "Path inside container is: $PWD"

for i in {1..50};
do
    if [ $? -eq 0 ]
    then
        echo "SQL Server is ready"
        if [ -f "/$RepositoryPath/SetupDatabase.sh" ]; then
            /$RepositoryPath/SetupDatabase.sh
        else
            dotnet ef migrations update --project DataAccess
        fi
        break
    else
        echo "Waiting for SQL Server..."
        sleep 1
    fi
done