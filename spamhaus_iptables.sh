#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
IPT="/sbin/iptables"
FILE="/tmp/spam_drop.txt"
URL_DROP="http://www.spamhaus.org/drop/drop.lasso"
URL_EDROP="http://www.spamhaus.org/drop/edrop.lasso"
URL_DSHIELD="http://feeds.dshield.org/block.txt"

/bin/echo ""
/bin/echo -n "Deleting DROP list from existing firewall"


#This will delete all dropped ips from firewall
ipdel=$(/bin/cat $FILE  | /bin/egrep -v '^;' | /usr/bin/awk '{ print $1}')

for ipblock in $ipdel
do
    $IPT -D droplist -s $ipblock -j DROP
done

echo -n "Applying DROP list to existing firewall"

#This will drop all ips from spamhaus list.
[ -f $FILE ] && /bin/rm -f $FILE || :
cd /tmp
/usr/bin/wget $URL_EDROP
/usr/bin/wget $URL_DROP
/usr/bin/wget $URL_DSHIELD -O dshield.txt
/bin/cat dshield.txt | /bin/grep -v '^#' | /bin/egrep -i '[0-9]{1,3}' | /usr/bin/cut -d$'\t' -f1,3 --output-delimiter '/' > $FILE
/bin/cat drop.lasso edrop.lasso | /usr/bin/sort -u >> $FILE
/bin/rm *.lasso
/bin/rm dshield.txt

blocks=$(cat $FILE  | egrep -v '^;' | awk '{ print $1}')
$IPT -N droplist

for ipblock in $blocks
do
    $IPT -A droplist -s $ipblock -j DROP
done

$IPT -D INPUT -j droplist
$IPT -I INPUT 2 -j droplist
$IPT -D OUTPUT -j droplist
$IPT -I OUTPUT -j droplist
$IPT -D FORWARD -j droplist
$IPT -I FORWARD -j droplist


/bin/echo "Done."
