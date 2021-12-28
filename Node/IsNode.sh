function IsNode() {
    if [ -f "IsNode" ]; then
        return 0;
    else 
        return 1;
    fi
}