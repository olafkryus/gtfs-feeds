#!/bin/bash

#
# get URL to download latest GTFS feed
#

PERMALINK="https://opentransportdata.swiss/de/dataset/timetable-2023-gtfs2020/permalink"

LOCATION=$(curl --connect-timeout 30 -sI $PERMALINK | fgrep -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')

if [ -n "$LOCATION" ]
then
    if [ "$(echo $LOCATION | grep -c '^https://opentransportdata.swiss/')" == 1 ]
    then
        RELEASE_URL=$LOCATION
    fi
fi

echo $RELEASE_URL
