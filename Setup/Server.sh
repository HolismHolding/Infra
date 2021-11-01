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

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

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
    docker-compose --version

    Write "Installed Docker Compose"
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
    apt install certbot
    apt install python3-certbot-nginx

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

UpdateApt
InstallCurl
InstallDocker
InstallDockerCompose
InstallNginx
InstallCertbot
InstallMicro
InstallTelnet
