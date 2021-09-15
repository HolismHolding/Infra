function CreateHolismDotNetDirectory() {
    if [ ! -d "/HolismDotNet" ]; then
        echo "Creating /HolismDotNet directory"
        sudo mkdir /HolismDotNet
        sudo chmod -R 777 /HolismDotNet
    fi
}