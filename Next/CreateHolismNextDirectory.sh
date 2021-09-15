function CreateHolismNextDirectory() {
    if [ ! -d "/HolismNext" ]; then
        echo "Creating /HolismNext directory"
        sudo mkdir /HolismNext
        sudo chmod -R 777 /HolismNext
    fi
}