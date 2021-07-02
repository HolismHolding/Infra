echo "alias dblogin='/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P lksU2o412f7tBj58t07B -d master'" >> /etc/bash.bashrc

echo "creating database for $Runnable"

rm -rf /temp/Script.sql

echo "create database $Runnable" >> /temp/Script.sql
echo "go" >> /temp/Script.sql

for i in {1..50};
do
    /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P lksU2o412f7tBj58t07B -d master -i /temp/Script.sql
    if [ $? -eq 0 ]
    then
        echo "database $Runnable is created"
        break
    else
        echo "waiting for SQL Server..."
        sleep 1
    fi
done