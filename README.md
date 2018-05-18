resech script repository
=====

These are a few scripts I use day to day for various tasks. There's probably a more efficient way, but fast and dirty is more fun. **Use at your own risk!**

Scripts in [unmaintained](./unmaintained) are older and may not work anymore. I've not removed them from the repo since I might find a use for them later.

LuhnTest.sh
------
Checks if script argument passes a Luhn check (used to determine valid credit card numbers) and retreives additional information from binlist if it does.

string_xor.py
------
Takes a file and XOR key as an argument and then saves a copy of the XOR'd output.


zap_weekly_update.sh
------
A basic script to find the current weekly build of ZAP and if it doesn't match the version we have installed, install it.