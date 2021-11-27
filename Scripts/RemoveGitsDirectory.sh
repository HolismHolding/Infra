function RemoveGitsDirectory()
{
    find . -type d -name ".git" | xargs rm -rf
}