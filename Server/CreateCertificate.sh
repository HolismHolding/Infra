# https://www.nginx.com/blog/using-free-ssltls-certificates-from-lets-encrypt-with-nginx/

export MainHost="freya.center"; \

certbot --nginx -d $MainHost \
	-d www.$MainHost \
	-d accounts.$MainHost \
	-d user.$MainHost \
	-d api.user.$MainHost \
	-d admin.$MainHost \
	-d api.admin.$MainHost
    # add other roles' panels and apis here
	