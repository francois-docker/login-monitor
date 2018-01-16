#! /bin/bash
function send_notif {
    TITLE="Warning - Connection from unknown IP"
    BODY="The IP address $1 succesfully logged in on you server"
    DATA='{"body": "'${BODY}'","title": "Warning - Connection from unknown IP","type":"note"}'

    curl -L --header "Access-Token: ${APITOKEN}" --header 'Content-Type: application/json' --data-binary "${DATA}" --request POST https://api.pushbullet.com/v2/pushes
    if [ $? -eq 0 ]; then
        return 0
    else
	return 1
    fi
}

AUTHORIZED_IPS="/root/authorized_ips.list"
ALREADY_SENT_IPS="/root/already_sent.list"
LOG_FILE="/root/log/auth.log"
FOUND_IPS=`cat $LOG_FILE | grep -i accepted | awk '{print $11}' | sort | uniq`

if [[ ! -v APITOKEN ]]; then
    echo "You need to provide a pushbullet API token for this container to be able to operate
        ie: docker run -e APITOKEN=<token> -v ... francois/login-monitor"
    exit 1
fi

for IP in $FOUND_IPS
do
    #If the ip address is not in the authorized_ip list
    if ! grep -Fxq "$IP" "$AUTHORIZED_IPS"; then
        echo "this ip: $IP is not authorized"

        #If the ip address has not laready be signaled by mail
        if ! grep -Fxq "$IP" "$ALREADY_SENT_IPS"; then
            echo "The notification regarding ip: $IP is being sent"
            send_notif $IP
	    if [ $? -eq 0 ]; then
		echo "Adding IP to already_sent_list"
                echo $IP >> $ALREADY_SENT_IPS
	    else
		echo "Erreur lors de l'envoi de la notification"
		exit 1
            fi
	else
            echo "This IP has already be signaled - Exiting..."
        fi
    fi
done
