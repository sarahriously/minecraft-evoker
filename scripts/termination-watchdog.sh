#!/bin/bash

echo 'Watchdog service starting'
TOKEN=`curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`

while sleep 5; do

    HTTP_CODE=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s -w %{http_code} -o /dev/null http://169.254.169.254/latest/meta-data/spot/instance-action)

    if [[ "$HTTP_CODE" -eq 401 ]] ; then
        echo 'Refreshing Authentication Token'
        TOKEN=`curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 30"`
    elif [[ "$HTTP_CODE" -eq 200 ]] ; then
        echo 'Termination notice received'
        screen -p 0 -S ${SCREENNAME} -X eval 'stuff "say [Warning] Server is about to shutdown, should come back up soon. Performing a backup..."\015'
        service minecraft backup_world
    else
        echo "$HTTP_CODE Not Interrupted"
    fi

done
