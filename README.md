# login-monitor
monitor successfull login from unknown ip

## Run
3 files must be provided to the container:
- auth.log: the system authentication log file to check
- authorized_ips.list: a list of authorized ip address (one per line)
- already_sent.list: an empty file to keep track of found ips

2 environment variables must also be provided:
- SMTP_HOST: the ip address or hostname of the smtp server to be used
- EMAIL_ADDR: the email address to send the notification to

```
docker run -ti --rm -v /var/log/auth.log:/root/log/auth.log -v ~/login-monitor/authorized_ips.list:/root/authorized_ips.list -v ~/login-monitor/already_sent.list:/root/already_sent.list -e SMTP_HOST=IPADDRESS -e EMAIL_ADDR=admin@domain.tld francois/login-monitor:latest
```
