echo "Path inside container is: $PWD"



for i in {1..50};
do
    if [ $? -eq 0 ]
    then
        echo "SQL Server is ready"
        #RunMigrations
        break
    else
        echo "Waiting for SQL Server..."
        sleep 1
    fi
done