# Server setup

- OS
    - Debian Buster
        - [10.10.0 x64](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-10.10.0-amd64-netinst.iso)
- NGINX
    - [1.20.1](https://nginx.org/download/nginx-1.20.1.tar.gz)
        - `sudo apt update`
        - `sudo apt install nginx`
- micro
    - `cd /usr/local/bin`
    - `curl https://getmic.ro | bash`
- certbot
    - `apt-get update`
    - `sudo apt-get install certbot`
    - `apt-get install python3-certbot-nginx`
