# Increase

- SSH into the server
- `docker exec -it OrganizationBlog bash`
- `cat .htaccess`
- `sed -i '/^# END WordPress.*/i php_value upload_max_filesize 256M\nphp_value post_max_size 256M' .htaccess`
- `cat .htaccess`
- `cd /Organization/Blog`
- `micro blog.domain.tld.conf`
- add

```
server {
    ...
    client_max_body_size 100M;
}
```

- `nginx -t`
- `nginx -s reload`

--- 

# Decrease
- `sed -i '/php_value/d' .htaccess`
- comment nginx line