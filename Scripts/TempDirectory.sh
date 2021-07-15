function MakeSureTempDirectoryExists() {
    if [ ! -d "/Temp" ]; then
        sudo mkdir /Temp
    fi
    permissions=$(stat /Temp | grep -oP "(?<=Access: \()[^)]*")
    if [  $permissions = "0777/drwxrwxrwx" ]; then
        echo '/Temp folder has full access'
    else 
        sudo chmod -R 777 /Temp
    fi 
}