#!/bin/bash

#
# get URL to download latest GTFS feed
#

DATASET_ID="55ffbe0888ee387348ccb97d"

JSON_URL="https://transport.data.gouv.fr/api/datasets/$DATASET_ID"

LOCATION=$(curl --connect-timeout 30 -s $JSON_URL -o - | \
         jq '.resources[0] | .original_url'           | \
         sed -e 's/"//g')

if [ -n "$LOCATION" ]
then
    RELEASE_URL=$LOCATION
fi

echo $RELEASE_URL