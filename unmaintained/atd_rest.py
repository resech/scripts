#!/usr/bin/env python

import argparse
import logging
import json

# Depends on updated atdlib for API calls
# Available at https://github.com/passimens/atdlib
import atdlib


#Setup basic loging
logging.basicConfig()

#Read Creds
with open('credentials.json') as creds:
	credentials = json.load(creds)

ip_address = str(credentials['ip_address'])
username = str(credentials['username'])
password = str(credentials['password'])

# Grab our Arguments
parser = argparse.ArgumentParser()
group = parser.add_mutually_exclusive_group()
group.add_argument("-f", "--full", action="store_true",
					help="Download the full scan results in one zip file")
group.add_argument("-p", "--pdf", action="store_true",
					help="Download the scan results in a PDF")
group.add_argument("-o", "--original", action="store_true",
					help="Download the original sample")
group2 = parser.add_mutually_exclusive_group()
group2.add_argument("-t", "--taskid", type=str, help="The Task ID of the sample")
group2.add_argument("-m", "--md5", type=str, help="MD5 Hash of the sample")
					
args = parser.parse_args()

if args.full == args.pdf == args.original == False:
	print "You must select -f, -p or -o."
	exit(1)

if args.taskid == args.md5 == None:
	print "You must provide a Task ID (-t) or MD5 (-m)"
	exit(1)
elif args.taskid is not None:
	id_md5 = False
else:
	id_md5 = True

	
if args.full:
	try:
		atd = atdlib.atdsession()
		atd.open(ip_address, username, password)
		if id_md5:
			with open('%s_full.zip' % args.md5, 'wb') as rep:
				rep.write(atd.md5report(args.md5, 'zip'))
			print "Full results saved as %s_full.zip" % args.md5
		else:
			with open('%s_full.zip' % args.taskid, 'wb') as rep:
				rep.write(atd.taskreport(args.taskid, 'zip'))
			print "Full results saved as %s_full.zip" % args.taskid
		atd.close
	except:
		atd.close
		exit(1)


if args.pdf:
	try:
		atd = atdlib.atdsession()
		atd.open(ip_address, username, password)
		if id_md5:
			with open('%s.pdf' % args.md5, 'wb') as rep:
				rep.write(atd.md5report(args.md5))
			print "Report saved as %s.pdf" % args.md5
		else:
			with open('%s.pdf' % args.taskid, 'wb') as rep:
				rep.write(atd.taskreport(args.taskid))
			print "Report saved as %s.pdf" % args.taskid
		atd.close
	except:
		atd.close
		exit(1)

if args.original:
	try:
		atd = atdlib.atdsession()
		atd.open(ip_address, username, password)
		if id_md5:
			with open('%s_sample.zip' % args.md5, 'wb') as rep:
				rep.write(atd.md5report(args.md5, 'sample'))
			print "Original sample saved as %s_sample.zip" % args.md5
		else:
			with open('%s_sample.zip' % args.taskid, 'wb') as rep:
				rep.write(atd.taskreport(args.taskid, 'sample'))
			print "Original sample saved as %s_sample.zip" % args.taskid
		atd.close	
	except:
		atd.close
		exit(1)

exit(0)
