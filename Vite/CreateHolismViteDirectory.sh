function CreateHolismViteDirectory() {
    if [ ! -d "/HolismVite" ]; then
        echo "Creating /HolismVite directory"
        sudo mkdir /HolismVite
        sudo chmod -R 777 /HolismVite
    fi
}