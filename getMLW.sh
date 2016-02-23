#!/bin/bash

URL="$(curl -Ss http://vxvault.net/URL_List.php | grep 'http' | shuf -n 1 | tr -d '\r')"

/usr/bin/python /home/thug/src/thug.py $URL
