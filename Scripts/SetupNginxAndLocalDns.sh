function SetupNginxAndLocalDns() {
    if [ -z ${Host+x} ]; then
        return;
    fi
    
    sudo chmod 777 /etc/hosts
    sudo chmod -R 777 /etc/nginx/conf.d

    echo "Setting up NGINX and local DNS";
    if ! grep -q " $Host" /etc/hosts; then
        echo "127.0.0.1 $Host" >> /etc/hosts;
    fi
    if [ -f "/etc/nginx/conf.d/$Host.conf" ]; then
        rm -rf "/etc/nginx/conf.d/$Host.conf";
    fi
    export host='$host';
    export http_upgrade='$http_upgrade';
    export scheme='$scheme';
    envsubst < /HolismHolding/Infra/NginxReverseProxyTemplate > /etc/nginx/conf.d/$Host.conf
    sed -i 's/https:\/\/;/https:\/\/$server_name$request_uri;/g' /etc/nginx/conf.d/$Host.conf
    #systemctl reload nginx
    sudo nginx -s reload
}