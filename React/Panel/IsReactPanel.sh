function IsReactPanel() {
    if [ -f "Menu.js" ]; then
        return 0;
    else
        return 1;
    fi
}