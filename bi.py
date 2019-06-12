#!/usr/bin/env python3
import sys ,struct
'''
	NAME
				bi - binary input
	SYNOPSIS
				fi number [option]
	DESCRIPTION
				a simple imparative script to convert binary input in TK to float number 
				to be used in Tk
	USAGE
				./bo 1000000101100000000000000000000
				5.5


'''
h = hex(int(sys.argv[1],2))
f = (struct.unpack('>f',bytes.fromhex(h[2:10]))[0])
print (round(f,ndigits=6))