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

Write "Holism Holding Installation"

Write "Creating VPN"

Write "Installing Google Chrome"

sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update 
sudo apt-get install google-chrome-stable

Write "Installed Google Chrome"

Write "Installing VS Code"

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

sudo apt install apt-transport-https
sudo apt update
sudo apt install code

code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-vscode-remote.remote-containers
code --install-extension esbenp.prettier-vscode

Write "Installed VS Code"