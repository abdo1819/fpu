#!/usr/bin/env python3
import sys ,struct
'''
	NAME
				fi - float input
	SYNOPSIS
				fi number [option]
	DESCRIPTION
				a simple imparative script to convert float input in TK to decimal/hex/binary number 
				to be used in modelsim
	DEFAULTS
				./fi 5.5
				1000000101100000000000000000000
	OPTIONS
				-d 		output will be in decimal form
				-h 		output will be in hexa-decimal form
				-b 		output will be in binary form

	USAGE
				./fi 1.23 -d
				1068457001

				Tcl 
				% set a_ [examin -binary a]
				% set _a ["$script.dir/ft.py $a -d"]

'''
if len(sys.argv)>2:
	if sys.argv[2] == "-d":
		print(int(struct.pack('>f',float(sys.argv[1])).hex(),16))
	elif sys.argv[2] == "-h":
		print (struct.pack('>f',float(sys.argv[1])).hex())
	elif sys.argv[2] == "-b":
		print (bin(int(struct.pack('>f',float(sys.argv[1])).hex(),16)).split("b")[1])
	else:
		print("invalid argument!")
		exit()
else:
	b = bin(int(struct.pack('>f',float(sys.argv[1])).hex(),16))[2:]
	if(len(b)<32):
		x = 32 - len(b)
		b = '0'*x+b
	print (b)
	