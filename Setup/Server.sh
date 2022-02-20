function Write()
{
    echo ""
    echo "----------"
    echo ""
    echo $1
    echo ""
    echo "----------"
    echo ""
}

function UpdateApt()
{
    Write "Updating apt ...";

    apt-get update

    Write "Updated apt"
}

function InstallCurl()
{
    Write "Installing curl ..."

    apt install curl -y

    Write "Installed curl"
}

function InstallNginx()
{
    Write "Installing Nginx ..."

    apt install nginx -y
    nginx -v

    Write "Installed Nginx"
}

function InstallCertbot()
{
    Write "Installing certbot ..."

    apt update
    apt install certbot -y
    apt install python3-certbot-nginx -y

    Write "Installed certbot"
}

function InstallMicro()
{
    Write "Installing Micro ..."

    cd /usr/local/bin
    curl https://getmic.ro | bash

    # or
    # wget https://github.com/zyedidia/micro/releases/download/v2.0.10/micro-2.0.10-amd64.deb
    # apt install ./micro-2.0.10-amd64.deb

    Write "Installed Micro"
}

function InstallTelnet()
{
    Write "Installing Telnet ..."

    apt-get install telnet -y

    Write "Installed Telnet"
}

function InstallAzcopy()
{
    Write "Installing AzCopy ..."
    
    # https://unix.stackexchange.com/a/154828/168855

    wget https://aka.ms/downloadazcopy-v10-linux &&
    mv downloadazcopy-v10-linux /azcopy_dir &&
    tar -xf /azcopy_dir &&
    rm -rf /azcopy_dir
    find / -type d -name "*azcopy*" -print0 | xargs -0 -I {} mv {} /azcopy_dir &&
    mv /azcopy_dir/azcopy /azcopy &&
    rm -rf /azcopy_dir

}

function InstallDocker()
{
    Write "Installing Docker ..."

    apt-get update

    apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release -y

    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

    apt-get update
    apt-get install docker-ce docker-ce-cli containerd.io -y
    docker run hello-world

    # gpasswd -a $USER docker
    # newgrp docker
    # groupadd docker
    # usermod -aG docker ${USER} restrat
    # usermod -aG docker $USER

    Write "Installed Docker"
}

function InstallDockerCompose()
{
    Write "Installing Docker Compose ..."

    curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

    chmod +x /usr/local/bin/docker-compose
    groupadd docker
    usermod -aG docker $USER
    docker-compose --version

    Write "Installed Docker Compose"
}

function RegisterHolismCommands()
{
    Write "Registering Holism Commands ..."

    sudo chmod 777 /etc/bash.bashrc
    sudo echo 'PATH="${PATH}:/HolismHolding/Server"' >> /etc/bash.bashrc

    Write "Registered Holism Commands"
}

UpdateApt
InstallCurl
InstallNginx
InstallCertbot
InstallMicro
InstallTelnet
InstallAzcopy
InstallDocker
InstallDockerCompose
RegisterHolismCommands

# notes:
# If docker is not installed, cancel and install docker manually by copy/pasting commands into the terminal
# If docker-compose can't be downloaded, download it on your PC and scp it onto the server
# Run this command for download
# sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /Temp/docker-compose
# Then copy it to server's /usr/local/bin/docker-compose