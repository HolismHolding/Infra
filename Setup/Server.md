# Server setup

- OS
    - Debian Bullseye
        - [debian-11.1.0-amd64-netinst](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.1.0-amd64-netinst.iso)
- Login with root
- Change root password (how?)
- Change ssh port

- Optionally change name servers
    - nano /etc/resolv.conf
    - to save
        - Ctrl+S
    - to exit
        - Ctrl+X
- NGINX
    - IMPORTANT NOTE => Only move /etc/nginx/sites-enabled/ and DO NOT MOVE /etc/nginx/sites-available/ because it's a symbolic link to that.
