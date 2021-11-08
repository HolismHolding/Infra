function DetermineTailwindConfigPath()
{
    if [ -f /$RepositoryPath/tailwind.config.js ]; then
        export TailwindConfigPath=$RepositoryPath
    else
        export TailwindConfigPath="/HolismNext/Infra"
    fi
}