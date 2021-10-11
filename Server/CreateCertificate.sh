# https://www.nginx.com/blog/using-free-ssltls-certificates-from-lets-encrypt-with-nginx/

export MainHost="freya.center"; \

certbot --nginx -d freya.center -d www.freya.center -d accounts.freya.center -d owner.freya.center -d api.owner.freya.center -d admin.freya.center -d api.admin.freya.center -d stylist.freya.center -d api.stylist.freya.center
 # add other roles' panels and apis here

# Setup this cron:
# 0 12 * * * /usr/bin/certbot renew --quiet

	