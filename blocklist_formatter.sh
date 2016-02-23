#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
cd /tmp

#Download the Blocklists
wget http://feeds.dshield.org/block.txt -O dshield.txt
wget http://www.spamhaus.org/drop/edrop.lasso -O SpamHaus_edrop.txt
wget http://www.spamhaus.org/drop/drop.lasso -O SpamHaus_drop.txt
wget https://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt -O emerging_threats.txt
wget https://malc0de.com/bl/IP_Blacklist.txt -O malcode.txt
wget "https://feodotracker.abuse.ch/blocklist/?download=ipblocklist" -O feodo.txt
wget "https://zeustracker.abuse.ch/blocklist.php?download=ipblocklist" -O zeus.txt
wget "https://palevotracker.abuse.ch/blocklists.php?download=ipblocklist" -O palevo.txt
wget http://www.malwaredomainlist.com/hostslist/ip.txt -O malware_domain.txt

#Format blocklists to the ESM format and move it to the sftp root
cat dshield.txt | grep -v '^#' | egrep -i '[0-9]{1,3}' | cut -d$'\t' -f1,3 --output-delimiter '/' > /srv/blocklists/dshield.txt
cat SpamHaus_drop.txt | grep -v '^;' | egrep -oe '[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}/[0-9]{1,2}' > /srv/blocklists/spamhaus_drop.txt
cat SpamHaus_edrop.txt | grep -v '^;' | egrep -oe '[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}/[0-9]{1,2}' > /srv/blocklists/spamhaus_edrop.txt
cat emerging_threats.txt | grep -v '^#' | egrep -e '[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}' > /srv/blocklists/emerging_threats.txt
cat malcode.txt | grep -v '^//' | egrep -e '[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}' > /srv/blocklists/malcode.txt
cat malware_domain.txt | egrep -e '[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}' > /srv/blocklists/malware_domain.txt
cat zeus.txt | grep -v '^#' | egrep -e '[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}' > /srv/blocklists/zeus_palevo_feodo.txt
cat feodo.txt | grep -v '^#' | egrep -e '[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}' >> /srv/blocklists/zeus_palevo_feodo.txt
cat palevo.txt | grep -v '^#' | egrep -e '[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}' >> /srv/blocklists/zeus_palevo_feodo.txt

#Cleanup
chmod 644 /srv/blocklists/*
rm /tmp/dshield.txt
rm /tmp/SpamHaus_edrop.txt
rm /tmp/SpamHaus_drop.txt
rm /tmp/emerging_threats.txt
rm /tmp/malcode.txt
rm /tmp/malware_domain.txt
rm /tmp/feodo.txt
rm /tmp/zeus.txt
rm /tmp/palevo.txt
