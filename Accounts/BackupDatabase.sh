docker-compose exec mariadb mysqldump -uroot -p${MARIADB_ROOT_PASSWORD} --all-databases > mariadb-dump-$(date +%F_%H-%M-%S).sql
