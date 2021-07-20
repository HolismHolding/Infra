echo "Path inside container is: $PWD"

function RunMigrations() {
    find / -type d -name Migrations 2>&- | grep DataAccess/Migrations |
    while read migrationDirectory; do
        dataAccess=$(dirname $migrationDirectory);
        echo "Running migrations for $dataAccess";
        dotnet ef database update --project $dataAccess &
    done 
}

for i in {1..50};
do
    if [ $? -eq 0 ]
    then
        echo "SQL Server is ready"
        RunMigrations
        break
    else
        echo "Waiting for SQL Server..."
        sleep 1
    fi
done