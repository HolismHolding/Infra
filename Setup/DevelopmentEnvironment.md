# This is an example of the development environment setup. This document is valid only for a company or a holding. **This document is not for EVERYONE**.

- BEFORE INSTALLATION
  - If this is not your first installation, make sure to backup ~/.ssh folder to be restored later. You can zip it and upload it to your google drive storage.

* OS

  - Ubuntu
    - Only 20.04 LTS
    - Only from ubunto.com
    - Bootable image
      - using [Rufus](https://rufus.ie/en_US/)
    - Boot
    - Choose **Install Ubuntu**
      - Select English (US)
    - Keyboard layout
      - Enlish (US)
    - Connect to WiFi
    - Minimal installation
      - Make sure no box is selected
    - Erase disk and install Ubuntu
      - Always be ready to lose your machine
      - Advanced features
        - None
    - Press **Install Now**
      - Press **Continue**
    - Where are you?
      - Choose Tehran
      - Press **Continue**
    - Computer name
      - YourNamePc or YourNameLaptop
    - **DO NOT** set up **Livepatch**
        - Hit **Next**
    - **DO NOT** help Ubuntu
        - Select **No, don't send system info**
    - Privacy (Location Services)
        - Up to you
    - Remove everything from the left bar
    - **DO NOT** install any other language
    - Change culture
        - Settings
        - Region & Language
        - English (United States)
    - [Enable root](https://askubuntu.com/questions/1192471/login-as-root-on-ubuntu-desktop) and login as root always (This decision is explained [here](https://nefcanto.ir/dev-circle/philosophy/why-root))

- `sudo mkdir /Temp`
- `sudo chmod 777 /Temp`
- `cd /Temp`
- `wget https://raw.githubusercontent.com/HolismHolding/Infra/main/Setup/DevelopmentEnvironment.sh`
- `sudo ./DevelopmentEnvironment.sh`

- **DO NOT** install any other extension on VS Code
    - In case you need something, talk to the team

* Software

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
  - Fiddler Everywhere
    - From [Official website](https://www.telerik.com/download/fiddler-everywhere)
      - Make executable
        - `sudo chmod +x filename.AppImage`
      - Double click to run
    - Enable [capturing HTTPS traffic](https://docs.telerik.com/fiddler-everywhere/user-guide/settings/https)
      - [Installation guide](https://askubuntu.com/a/649463/1269127) for Ubuntu
  - Azure Data Studio
    - If not connecting, [update OpenSSL](https://github.com/microsoft/azuredatastudio/issues/13457#issuecomment-832202549)
  - Nginx
    - `sudo apt-get update`
    - `sudo apt-get install nginx`
    - verify the installation => `sudo nginx -v`
  - rename
    - `sudo apt install rename`
  - baobab
    - `sudo apt-get install -y baobab`

* Development
  - For each company (top-level URL path segment in GitHub for example), create a directory in / (root). For example,  
    `mkdir /HolismHolding`.
    - Make sure the name maps the URL segment or the company name - Use [snake-casing](https://en.wikipedia.org/wiki/Snake_case) for naming
  - Give that folder full permission so that all applications would work without bothering your development with `sudo` stuff:  
    `sudo chmod -R 777 /HolismHolding`
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
