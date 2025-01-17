#!/bin/bash

#
# retrieve release date of latest GTFS feed in form "YYYY-MM-DD"
#

RELEASE_URL=$(./get-release-url.sh)

if [ -n "$RELEASE_URL" ]
then
    LAST_MODIFIED=$(curl --connect-timeout 30 -sI $RELEASE_URL | egrep -i '^(HTTP/. 404|last-modified:)')

    if [ -n "$LAST_MODIFIED" ]
    then
        if [ $(echo $LAST_MODIFIED |fgrep -c 'HTTP/2 200') -eq 1 ]
        then
            LAST_MODIFIED=$(echo $LAST_MODIFIED | sed -e 's/.*last-modified:\s*//i')
            result=$(date -d "$LAST_MODIFIED" '+%Y-%m-%d')
            if [ "$(echo $result | grep -c '^20[0-9][0-9]-[01][0-9]-[0123][0-9]$')" == 1 ]
            then
                RELEASE_DATE=$result
            fi
        else
            curl --connect-timeout 30 -sI $RELEASE_URL | grep -i '^HTTP/' > ./release_date_error.log
        fi
    else
        curl --connect-timeout 30 -sI $RELEASE_URL | grep -i '^HTTP/' > ./release_date_error.log
    fi
fi

echo $RELEASE_DATE
