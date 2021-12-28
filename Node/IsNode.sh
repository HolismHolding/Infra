function IsNode() {
    if [ -f "IsNode" ]; then
        echo 'is node'
        return 0;
    else 
        echo 'is not node'
        return 1;
    fi
}