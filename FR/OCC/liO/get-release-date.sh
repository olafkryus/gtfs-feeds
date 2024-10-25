#!/bin/bash

#
# get URL to download latest GTFS feed
#

DATASET_ID="647148f898aadb3cec613674"

JSON_URL="https://transport.data.gouv.fr/api/datasets/$DATASET_ID"

UPDATED=$(curl --connect-timeout 30 -s $JSON_URL -o -               | \
          jq -r '.resources[] | select(.format=="GTFS") | .updated' | \
          sort                                                      | \
          tail -1                                                   | \
          sed -e 's/"//g')

if [ -n "$UPDATED" ]
then
    result=$(date -d "$UPDATED" '+%Y-%m-%d')
    if [ "$(echo $result | grep -c '^20[0-9][0-9]-[01][0-9]-[0123][0-9]$')" == 1 ]
    then
        RELEASE_DATE=$result
    fi
fi

echo $RELEASE_DATE
