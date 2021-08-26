function GetDotNetAccounts() {
    accountsPath=/HolismDotNet/Accounts
    if [ -d "$accountsPath" ]; then
        echo "Pulling $accountsPath"
        git -C $accountsPath pull
    else 
        echo "Cloning $accountsPath"
        git -C /HolismDotNet clone git@github.com:HolismDotNet/Accounts
    fi
}