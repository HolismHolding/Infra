#!/bin/bash

# azure data studio + compare extension + profilder extension + agent extension

function Write()
{
    sudo echo ""
    sudo echo "----------"
    sudo echo ""
    sudo echo $1
    sudo echo ""
    sudo echo "----------"
    sudo echo ""
}

function InstallChrome()
{
    Write "Installing Google Chrome ..."

    sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
    sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
    sudo apt-get update 
    sudo apt-get install google-chrome-stable -y

    Write "Installed Google Chrome"
}

function InstallVsCode()
{
    Write "Installing VS Code ..."

    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg

    sudo apt install apt-transport-https
    sudo apt update
    sudo apt install code -y

    code --install-extension ms-azuretools.vscode-docker
    code --install-extension ms-vscode-remote.remote-containers
    code --install-extension esbenp.prettier-vscode

    Write "Installed VS Code"
}

function InstallGit()
{
    Write "Installing Git ..."

    sudo apt-get install git -y

    Write "Installed Git"
}

function InstallDocker()
{
    Write "Installing Docker ..."

    sudo apt-get update

    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release -y

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y

    Write "Installed Docker"
}

function InstallVpn()
{
    Write "Creating VPN ..."
}

Write "Holism Holding Installation"

InstallChrome
InstallVsCode
InstallGit
InstallDocker