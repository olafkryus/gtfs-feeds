#!/bin/bash

#
# get URL to download latest GTFS feed
#

PERMALINK="https://www.data.gouv.fr/fr/datasets/r/47bc8088-6c72-43ad-a959-a5bbdd1aa14f"

LOCATION=$(curl -sI $PERMALINK | fgrep -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')

if [ -n "$LOCATION" ]
then
    if [ "$(echo $LOCATION | grep -c 'horaires-theoriques-du-reseau-palmbus-cannes-pays-de-lerins-gtfs')" == 1 ]
    then
        RELEASE_URL=$LOCATION
    fi
fi

echo $RELEASE_URL
