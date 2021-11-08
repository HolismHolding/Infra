- create a crontab for organization, using `crontab -e`, or by `micro /var/spool/cron/crontabs/root`:

    - `0 10 * * * /Organization/Backup.sh`

- In `Backup.sh` write this script:

```
SECONDS=0;
/azcopy copy /Organization "https://organization.blob.core.windows.net/backup/?sas" --recursive=true
/usr/bin/echo "$(date) - Backup completed - Took $SECONDS seconds" >> /Organization/CronLog
```

- To test speed, use

    - `/azcopy benchmark "https://organization.blob.core.windows.net/backup/?sas"`   


- To download backup from Azure

    - `mkdir /Organization`
    - `chmod 777 /Organization`
    - `/azcopy copy "https://organization.blob.core.windows.net/backup/?sas" /Organization --recursive=true`