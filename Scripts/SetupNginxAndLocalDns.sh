function SetupNginxAndLocalDns() {
    if [ -z ${Host+x} ]; then
        return;
    fi
    echo "Setting up NGINX and local DNS";
    if ! grep -q " $Host" /etc/hosts; then
        echo "127.0.0.1 $Host" >> /etc/hosts;
    fi
    if [ -f "/etc/nginx/conf.d/$Host.conf" ]; then
        rm -rf "/etc/nginx/conf.d/$Host.conf";
    fi
    envsubst < /HolismHolding/Infra/NginxReverseProxyTemplate > /etc/nginx/conf.d/$Host.conf
    sed -i 's/https:\/\/;/https:\/\/$server_name$request_uri;/g' /etc/nginx/conf.d/$Host.conf
    #systemctl reload nginx
    sudo nginx -s reload
}