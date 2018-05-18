#!/bin/bash

URL="$(curl -Ss http://www.malwaredomainlist.com/hostslist/hosts.txt | grep '127.0.0.1' | grep -v localhost | tr -s ' ' | cut -d ' ' -f 2 | shuf -n 1 | tr -d '\r')"


/usr/bin/python /home/thug/src/thug.py $URL
