function CreateHolismNodeDirectory() {
    if [ ! -d "/HolismNode" ]; then
        echo "Creating /HolismNode directory"
        sudo mkdir /HolismNode
        sudo chmod -R 777 /HolismNode
    fi
}