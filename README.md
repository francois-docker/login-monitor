# login-monitor
monitor successfull login from unknown ip

## Run
3 files must be provided to the container:
- auth.log: the system authentication log file to check
- authorized_ips.list: a list of authorized ip address (one per line)
- already_sent.list: an empty file to keep track of found ips

1 environment variable must also be provided:
- APITOKEN: the pushbullet api token to be used to send notification

```
docker run -ti --rm -v /var/log/auth.log:/root/log/auth.log -v ~/login-monitor/authorized_ips.list:/root/authorized_ips.list -v ~/login-monitor/already_sent.list:/root/already_sent.list -e APITOKEN=<token> francois/login-monitor:latest
```

