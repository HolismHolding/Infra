# This is an example of the development environment setup. This document is valid only for a company or a holding. **This document is not for EVERYONE**.

- OS
    - Ubuntu
        - Only 20.04 LTS
        - Only from ubunto.com
        - Only English (US) as default

- Software
    - Git
        - Only 2.31.1
        - Only from https://git-scm.com/downloads
        - Setup to not detect `chmod` commands
            - `git config core.fileMode false`

    - VS Code (any version above 1.56.2)
        - Must install [Grammarly (unofficial)](https://marketplace.visualstudio.com/items?itemName=znck.grammarly&ssr=false#overview) extension
        - Must install [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) extension
        - Must install [C#](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp) extension
    - Docker
        - Only from [docker.com](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository) and using `apt` repository
        - Must be accompanied by [composer](https://docs.docker.com/compose/install/)
        - Must add your user to docker group
            - `sudo usermod -aG docker **your_user_name**`
            - Get your user name using `whoami` command
    - .NET Core SDK (this can be skipped and be used inside docker containers)
        - Only [3.1](https://dotnet.microsoft.com/download/dotnet/3.1) using [docs](https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#2004-)
            - MAKE SURE YOU REPLACE THE SDK VERSION.
            - Ask a senior in case you're in doubt.
            - In case of error, [troubleshoot](https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#apt-troubleshooting)
    - Notepad++
        - `sudo snap install notepad-plus-plus`
- Development
    - For each company (top-level URL path segment in GitHub for example), create a directory in / (root). For example,    
    `mkdir /nefcanto`.   
        - Make sure the name maps the URL segment or the company name
        - Use [snake-casing](https://en.wikipedia.org/wiki/Snake_case) for naming
    - Give that folder full permission so that all applications would work without bothering your development with `sudo` stuff:   
    `sudo chmod -R 777 /nefcanto`

<hr />

# Arguments

- Pros
    - Maximum level of consistency across the entire organization or holding
    - Drastically facilitates cooperation and teamwork
    - Reduces costs notably
    - Increases efficiency
        - Not at the cost of effectiveness
- Cons
    - Limits employee freedom
    - Makes the recruitment process more difficult
    - Can be regarded as a form of technocratic dictatorship