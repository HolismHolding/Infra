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
      - **DO NOT** choose auto-login
      - If you choose auto-login, you will encouner *keyring* later. To disable auto-login later:
        - Settings
        - User
        - Unlock
        - disable Automatic Login
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

  - Fiddler Everywhere

    - From [Official website](https://www.telerik.com/download/fiddler-everywhere)
      - Make executable
        - `sudo chmod +x filename.AppImage`
      - Double click to run
    - Enable [capturing HTTPS traffic](https://docs.telerik.com/fiddler-everywhere/user-guide/settings/https)
      - [Installation guide](https://askubuntu.com/a/649463/1269127) for Ubuntu

  - Git 
    - Restore `.ssh` directory, or
    - Generate keys and add your public key to GitHub 
      - Open terminal 
      - ssh-keygen -t ed25519 -C "your-email" 
      - Enter 3 times 
        - Accept default filename 
        - Empty password 
        - Empty password, again 
      - GitHub 
        - Settings 
        - SSH and GPG keys 
        - New SSH Key 
        - Copy/paste your public key there 
          - Using Files 
          - Go to the home folder 
          - Show hidden files 
          - .ssh folder 
          - id_ed25519.pub 
          - Right-click, open with the Text Editor, then copy 
    - Introduce yourself to git 
      - `git config --global user.email "your-email-of-github-here"` 
      - `git config --global user.name "your name here"`
  - Docker
    - In case of permission denied, run commands from [here](https://stackoverflow.com/questions/59265190/permission-denied-in-docker-compose-on-linux)
  - Configuration
    - Add these to favorites, in order
      - Files
      - Chrome
      - VS Code
      - Terminal
      - Azure Data Studio
  - Chrome
    - Make default
      - On the first run, it asks for it
    - Do not send crash reports
    - Sign in
    - Extensions
      - JSONView
      - Grammarly
      - React Developer Tools
  - VS Code
    - Word wrap
      - Files => Preferences => Settings
      - Search for “word wrap”
      - Select “on” from the dropdown
  - Azure Data Studio
    - Disable telemetry
      - Settings => search for Telemetry
  - Keyboard
    - Settings
      - Universal access
      - Typing
      - Repeat keys
      - Delay = almost 10%
      - Speed = almost 60%
  - Root
    - `sudo mkdir -p /root/.ssh`
    - `sudo ln -f -s ~/.ssh/id_ed25519 /root/.ssh/id_ed25519`
    - `sudo ln -f -s ~/.ssh/id_ed25519.pub /root/.ssh/id_ed25519.pub`
    - `sudo ln -f -s ~/.ssh/known_hosts /root/.ssh/known_hosts`

* Development
  - For each company (top-level URL path segment in GitHub for example), create a directory in / (root). For example,  
    `mkdir /HolismHolding`.
    - Make sure the name maps the URL segment or the company name
  - Give that folder full permission so that all applications would work without bothering your development with `sudo` stuff:  
    `sudo chmod -R 777 /HolismHolding`
  - Only [use SSH to connect to GitHub](https://www.freecodecamp.org/news/how-to-fix-git-always-asking-for-user-credentials/).

---

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
