UNMAINTAINED
===

These scripts are no longer maintained. They might work, they might not.

atd\_rest.py
------
A quick retrevial script that pulls results from Advanced Threat Defense. Depends on atdlib at [atdlib.py](https://github.com/passimens/atdlib).

spamhaus\_iptables.sh
-----
Fetches both Spamhaus lists along with the Dshield Top 20, performs some formatting and adds them to the iptables block chain.


blocklist\_formatter.sh
------
Grabs a few different blocklists and then formats them for use in McAfee's ESM solution as watchlists. Combine with cron and http/ftp and you've got dynamic watchlists.

getMLW.sh
------
Picks a random site  from vxvault.net and then feeds the URL to a containerized Thug instance. Part of an attempt to simulate some client traffic to Malware sites/binaries.

getURL.sh
------
Similar to getMLW.sh, this script feeds domains found to contain malware to Thug for automated crawling and analysis.