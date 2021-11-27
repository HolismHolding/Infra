function RemoveGitsDirectory()
{
    find /Build -type d -name ".git" | xargs rm -rf
}