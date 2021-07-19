function IsReactPanel() {
    if [ -f "App.js" ] || [ -f "Resources.js" ]; then
        return 0;
    else
        return 1;
    fi
}