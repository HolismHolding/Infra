echo "alias DbLogin='/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P lksU2o412f7tBj58t07B -d master'" >> /etc/bash.bashrc

for i in {1..50};
do
    /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P lksU2o412f7tBj58t07B -d master -i /Temp/Script.sql
    if [ $? -eq 0 ]
    then
        echo "SQL Server is ready"
        break
    else
        echo "waiting for SQL Server..."
        sleep 1
    fi
done