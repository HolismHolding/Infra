function IsVite() {
    if [ -f "Menu.jsx" ]; then
        return 0;
    else
        return 1;
    fi
}