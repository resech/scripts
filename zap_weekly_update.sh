#!/bin/bash

INSTALLED_DIR="/tmp/ZAP_PROXY"

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
    cp -Rf $INSTALLED_DIR/ZAP_$CURRENT/* $INSTALLED_DIR/ZAP_Files
    rm -rf $INSTALLED_DIR/ZAP_$CURRENT
    rm -rf $INSTALLED_DIR/ZAP_Files/zap-$INSTALLED.jar
    INSTALLED=$CURRENT
    echo $INSTALLED > $INSTALLED_DIR/installed.txt
    echo "Upgrade complete, Installed version is $INSTALLED."
else
    echo "Already up to date"
fi

exit 0