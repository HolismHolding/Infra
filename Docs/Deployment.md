# Deployment

- export Organization=OrganizationNameHear
- `cd /`
- `mkdir /$Organization`
- `cd /$Organization`
- `mkdir Applications`
- `mkdir Databases`
- `cd /$Organization/Applications`
- `mkdir Accounts`
- `cd /$Organization/Databases`
- `mkdir Accounts`
- `scp /HolismHolding/Infra/Accounts/DockerCompose.yml root@server:/$Organization/Applications/Accounts`
- `# replace passwords, backup passwords, replce mount directory`
