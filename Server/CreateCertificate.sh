export MainHost="put-your-$MainHost-here";

certbot --nginx -d $MainHost.com \
	-d www.$MainHost.com \
	-d accounts.$MainHost.com \
	-d user.$MainHost.com \
	-d api.user.$MainHost.com \
	-d admin.$MainHost.com \
	-d api.admin.$MainHost.com
    # add other roles' panels and apis here