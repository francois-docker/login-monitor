#! /bin/bash
function sendmail {
    export SUBJECT=ATTENTION: Login from unknown ip
    export SMTP=172.17.0.7:25
    export EMAIL=fbillant@gmail.com
    echo "WARNING: The unauthorised address ip: $1 has successfully login on your server" | mailx -S smtp=$SMTP -s "$SUBJECT" "$EMAIL"
}

AUTHORIZED_IPS="/root/authorized_ips.list"
ALREADY_SENT_IPS="/root/already_sent.list"
LOG_FILE="/root/log/auth.log"
FOUND_IPS=`cat $LOG_FILE | grep -i accepted | cut -d " " -f 11 | uniq`

for IP in $FOUND_IPS
do
    #If the ip address is not in the authorized_ip list
    if ! grep -Fxq "$IP" "$AUTHORIZED_IPS"; then
        echo "this ip: $IP is not authorized"

        #If the ip address has not laready be signaled by mail
        if ! grep -Fxq "$IP" "$ALREADY_SENT_IPS"; then
            echo "The mail regarding ip: $IP is being sent"
            sendmail $IP
            sleep 3
            echo $IP >> $ALREADY_SENT_IPS
        fi
    fi
done

