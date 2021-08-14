# Server setup

- OS
    - Debian Buster
        - [10.10.0 x64](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-10.10.0-amd64-netinst.iso)
- Login with root
- Change root password (how?)
- Change ssh port
    - 
- NGINX
    - [1.20.1](https://nginx.org/download/nginx-1.20.1.tar.gz)
        - `apt update`
        - `apt install nginx`
- curl
    - `apt install curl`
- micro
    - `cd /usr/local/bin`
    - `curl https://getmic.ro | bash`
- certbot
    - `apt update`
    - `apt install certbot`
    - `apt install python3-certbot-nginx`
- docker
    - `apt update`
    - `apt-get install \     
        apt-transport-https \   
        ca-certificates \   
        curl \    
        gnupg \   
        lsb-release`
    -  `curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg`
    - `echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null`
    - `apt update`
    - `apt install docker-ce docker-ce-cli containerd.io`
    - `docker run hello-world`
- docker-compose
    - `curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose`
    - `chmod +x /usr/local/bin/docker-compose`
    - `groupadd docker`
    - `usermod -aG docker $USER`

