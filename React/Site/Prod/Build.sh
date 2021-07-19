function IsReactSite() {
    if [ -d "pages" ]; then
        return 0;
    else 
        return 1;
    fi
}