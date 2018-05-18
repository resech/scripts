#!/bin/bash

INSTALLED_DIR="/Users/rsechler/ZAProxy"

CURRENT=`curl -s "https://raw.githubusercontent.com/zaproxy/zap-admin/master/ZapVersions.xml" | grep daily-version | awk -v FS="(<daily-version>|</daily-version>)" '{print $2}'`
INSTALLED=`cat $INSTALLED_DIR/installed.txt`

if [ ! -f $INSTALLED_DIR/installed.txt ]; then
    INSTALLED='0'
else
    INSTALLED=`cat $INSTALLED_DIR/installed.txt`
fi

if [ $INSTALLED != $CURRENT ]; then
    TEMPFILE=`mktemp`
    URL=`curl -s "https://raw.githubusercontent.com/zaproxy/zap-admin/master/ZapVersions.xml" | grep "ZAP_WEEKLY_D" | grep "<url>" | awk -v FS="(<url>|</url>)" '{print $2}'`
    wget $URL -O $TEMPFILE; unzip -d $INSTALLED_DIR $TEMPFILE; rm $TEMPFILE
    mv $INSTALLED_DIR/ZAP_$CURRENT $INSTALLED_DIR/ZAP_Files
    INSTALLED=$CURRENT
    echo $CURRENT > $INSTALLED_DIR/installed.txt
else
    echo "Already up to date"
fi

exit 0