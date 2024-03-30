#!/bin/bash

#
# get URL to download latest GTFS feed
#

echo $(curl -s https://api.github.com/repos/gtfs-proxies/24-ZTM-Katowice/releases/latest | \
       jq -r '.assets.[0].browser_download_url')