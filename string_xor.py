#!/usr/bin/env python

import argparse
import binascii

# Grab our Arguments
parser = argparse.ArgumentParser()
parser.add_argument("FileName", help="Enter the name of the XOR'd file",
                    type=str)
parser.add_argument("XOR_Key",
                    help="Enter the XOR key, can be a single byte or a string",
                    type=str)
parser.add_argument("OutputFile",
                    help="Enter the location you'd like the file written to.",
                    type=str)
args = parser.parse_args()

#This list will contain the decimal representations of our binary file.
xord_decimal = []

#Put our key into a list
xor_key = list(args.XOR_Key)

with open(args.FileName, "rb") as f:
    i = 0
    byte = f.read(1)
    while byte != "":
        # Convert the byte into a decimal
        byte_dec = int((binascii.hexlify(byte)), 16)
        # Do the same with xor_key
        key_dec = int((binascii.hexlify(xor_key[i])), 16)
        # Do some XOR and feed it to the list
        xor_dec = key_dec ^ byte_dec
        xord_decimal.append(xor_dec)

        # Looping logic garbage
        i += 1
        if i >= len(xor_key):
            i = 0

        byte = f.read(1)

# Now we dump the xord_decimal list to a file
# Create a byte array
xord_bytearray = bytearray(xord_decimal)
outfile = open(args.OutputFile, "wb")
outfile.write(xord_bytearray)
outfile.close
