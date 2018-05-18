#!/bin/bash

# Set the Desired Output Location
FILELOCATION="/tmp"

# Blocklist Variables
DSHIELD="http://feeds.dshield.org/block.txt"
SPAMDROP="http://www.spamhaus.org/drop/edrop.lasso"
SPAMEDROP="http://www.spamhaus.org/drop/drop.lasso"
EMERGING="https://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt"
MALCODE="https://malc0de.com/bl/IP_Blacklist.txt"
FEODO="https://feodotracker.abuse.ch/blocklist/?download=ipblocklist"
ZEUS="https://zeustracker.abuse.ch/blocklist.php?download=ipblocklist"
PALEVO="https://palevotracker.abuse.ch/blocklists.php?download=ipblocklist"
MALWAREDOMAIN="http://www.malwaredomainlist.com/hostslist/ip.txt"
RANSOM="https://ransomwaretracker.abuse.ch/downloads/RW_IPBL.txt"

function list_format # Expects one  argument
{
	URL=$1
	BLOCKLIST=$(wget -qO- $URL)
	OUTPUT=$(grep -v -E '^;|^#|^//' <<< "$BLOCKLIST" | egrep -oe '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/[0-9]{1,2}|[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
	echo $OUTPUT
}



#DSHIELD is really unique, instead of creating a distinct function, I just do it all off one line
DSHIELD_OUT=$(wget -qO- $DSHIELD | grep -v '^#' | egrep -i '[0-9]{1,3}' | cut -d$'\t' -f1,3 --output-delimiter '/'); echo $DSHIELD_OUT | tr " " "\n" > $FILELOCATION/DSHIELD.txt

#Call and format the other lists
SPAMDROP_OUT=$(list_format "$SPAMDROP"); echo $SPAMDROP_OUT | tr " " "\n" > $FILELOCATION/SPAMDROP.txt
SPAMEDROP_OUT=$(list_format "$SPAMEDROP"); echo $SPAMEDROP_OUT | tr " " "\n" > $FILELOCATION/SPAMEDROP.txt
EMERGING_OUT=$(list_format "$EMERGING"); echo $EMERGING_OUT | tr " " "\n" > $FILELOCATION/EMERGING.txt
MALCODE_OUT=$(list_format "$MALCODE"); echo $MALCODE_OUT | tr " " "\n" > $FILELOCATION/MALCODE.txt
FEODO_OUT=$(list_format "$FEODO"); echo $FEODO_OUT | tr " " "\n" > $FILELOCATION/FEODO.txt
ZEUS_OUT=$(list_format "$ZEUS"); echo $ZEUS_OUT | tr " " "\n" > $FILELOCATION/ZEUS.txt
PALEVO_OUT=$(list_format "$PALEVO"); echo $PALEVO_OUT | tr " " "\n" > $FILELOCATION/PALEVO.txt
MALWAREDOMAIN_OUT=$(list_format "$MALWAREDOMAIN"); echo $MALWAREDOMAIN_OUT | tr " " "\n" > $FILELOCATION/MALWAREDOMAIN.txt
RANSOM_OUT=$(list_format "$RANSOM"); echo $RANSOM_OUT | tr " " "\n" > $FILELOCATION/RANSOM.txt

