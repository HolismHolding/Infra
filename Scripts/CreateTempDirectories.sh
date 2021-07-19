function CreateTempDirectories() {
    if [ ! -d "/Temp" ]; then
        sudo mkdir /Temp
    fi
    permissions=$(stat /Temp | grep -oP "(?<=Access: \()[^)]*")
    if [  $permissions = "0777/drwxrwxrwx" ]; then
        echo '/Temp folder has full access'
    else 
        sudo chmod -R 777 /Temp
    fi
    if [ -z ${Organization+x} ]; then
        return;
    fi
    if [ -z ${Repository+x} ]; then
        return;
    fi
    mkdir -p /Temp/$Organization/$Repository
    if [ -d /Build ]; then
        sudo rm -rf /Build
    fi
    sudo mkdir /Build
    sudo chmod -R 777 /Build
}