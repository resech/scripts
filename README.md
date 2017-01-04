resech script repository
=====

These are a few scripts I use day to day for various tasks. There's probably a more efficient way, but fast and dirty is more fun. **Use at your own risk!**

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

LuhnTest.sh
------
Checks if script argument passes a Luhn check (used to determine valid credit card numbers) and retreives additional information from binlist if it does.

string_xor.py
------
Takes a file and XOR key as an argument and then saves a copy of the XOR'd output.

atd\_rest.py
------
A quick retrevial script that pulls results from Advanced Threat Defense. Depends on an updated atdlib at [atdlib.py](https://github.com/resech/atdlib/blob/devel/atdlib.py) until the upstream is updated.
