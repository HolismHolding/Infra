# This is an example of the development environment setup. This document is valid only for a company or a holding. **This document is not for EVERYONE**.

- OS
    - Ubuntu
        - Only 20.04 LTS
        - Only from ubunto.com
        - Only English (US) as default
        - [Enable root](https://askubuntu.com/questions/1192471/login-as-root-on-ubuntu-desktop) and login as root always (This decision is explained [here](https://nefcanto.ir/dev-circle/philosophy/why-root))

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
        - Then install `dotnet-format`
            - `dotnet tool install -g dotnet-format`
        - Then install `dotnet-script`
            - `dotnet tool install -g dotnet-script`
    - Fiddler Everywhere
        - From [Official website](https://www.telerik.com/download/fiddler-everywhere)
        - Enable [capturing HTTPS traffic](https://docs.telerik.com/fiddler-everywhere/user-guide/settings/https)
            - [Installation guide](https://askubuntu.com/a/649463/1269127) for Ubuntu
    - Azure Data Studio
        - If not connecting, [update OpenSSL](https://github.com/microsoft/azuredatastudio/issues/13457#issuecomment-832202549)
    - SQL Server
        - Follow [docs](https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-ubuntu?view=sql-server-ver15)
            - Use `--no-check-certificate` after `wget`
            - Check [this link](https://askubuntu.com/questions/1109982/e-could-not-get-lock-var-lib-dpkg-lock-frontend-open-11-resource-temporari) for lock error
    - node.js
        - Disable `strict-ssl` using `sudo nano /usr/local/lib/node_modules/npm/npmrc` and adding this line: `strict-ssl=false`
    - rename
        - `sudo apt install rename`
    - baobab
        - `sudo apt-get install -y baobab`

- Development
    - For each company (top-level URL path segment in GitHub for example), create a directory in / (root). For example,    
    `mkdir /nefcanto`.   
        - Make sure the name maps the URL segment or the company name
        - Use [snake-casing](https://en.wikipedia.org/wiki/Snake_case) for naming
    - Give that folder full permission so that all applications would work without bothering your development with `sudo` stuff:   
    `sudo chmod -R 777 /nefcanto`
    - Add environment variable for each **x_projects_root**
        - Give write access to `/etc/profile` file.
        - Open it in an editor
        - At the end add the environment variables
            - export nefcanto_projects_root=/nefcanto
            - export x_projects_root=/x
            - export y_projects_root=/y
        - Save, and readonly again
        - Restart
    - Download the "company-wide" git bash file, to pull and push all repositories of a company in one step (without messages)
    - Only [use SSH to connect to GitHub](https://www.freecodecamp.org/news/how-to-fix-git-always-asking-for-user-credentials/).
    - For each project
        - `cd` into project's directory
        - `./setup`
            - Better to find a way to simply run `setup`
        - `./serve`
            - Better to find a way to simply run `serve`

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