. /HolismHolding/Infra/Scripts/Message.sh

function SetupNginxAndLocalDns() {
    if [ -z ${Host+x} ]; then
        return;
    fi
    
    sudo chmod 777 /etc/hosts
    sudo chmod -R 777 /etc/nginx/conf.d

    Info "Setting up NGINX and local DNS for $Host ...";
    if ! grep -q " $Host" /etc/hosts; then
        echo "127.0.0.1 $Host" >> /etc/hosts;
    fi
    if [ -f "/etc/nginx/conf.d/$Host.conf" ]; then
        rm -rf "/etc/nginx/conf.d/$Host.conf";
    fi
    export NginxParamsServerName='$server_name'
    export NginParamsRequestUri='$request_uri'
    export NginxHostParameter='$host';
    export NginxSchemeParameter='$scheme';
    export NginxHttpUpgradeParameter='$http_upgrade';
    envsubst < /HolismHolding/Infra/NginxReverseProxyTemplate > /etc/nginx/conf.d/$Host.conf
    sed -i 's/https:\/\/;/https:\/\/$server_name$request_uri;/g' /etc/nginx/conf.d/$Host.conf
    #systemctl reload nginx
    sudo nginx -s reload
}