# Create
- `micro /var/spool/cron/crontabs/root`
or
- `crontab -e`

# See the list of crontabs
- `crontab -l`

# Enable logging
- `micro /etc/rsyslog.conf`   
- find    `#cron.*                     -/var/log/cron`
- remove #
- `service rsyslog restart`

# Check cron is running
`ps -ef | grep cron | grep -v grep`

# Start cron service
`/sbin/service cron start`

# Some crons
- `0 4 * * * /Organization/Backup`
- `0 6 * * * /Organization/Restart`
- `0 12 * * * /usr/bin/certbot renew --quiet`
- `0 8 * * * docker system prune --force`

# To test cron
- `crontab /var/spool/cron/crontabs/root`
    - **(or any other file) => runs (caution => it might run continuously, causing a lot of bandwidth and cost on services, thus preferrably never run it)**