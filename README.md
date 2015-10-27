# login-monitor
monitor successfull login from unknown ip

## Run
3 files must be provided to the container:
- auth.log: the system authentication log file to check
- authorized_ips.list: a list of authorized ip address (one per line)
- already_sent.list: an empty file to keep track of found ips

```
docker run -ti --rm -v /var/log/auth.log:/root/log/auth.log -v ~/login-monitor/authorized_ips.list:/root/authorized_ips.list -v ~/login-monitor/already_sent.list:/root/already_sent.list francois/login-monitor:latest
```

TODO:
- Make the smtp server a variable to be passed to the container via an environment variable
