#!/usr/local/bin/python3.5
#Author: Ann Le, McMaster University
#retrieves the sequences from a list of protIDs to create a fasta file for the oneway NR blast
#argv[2] is concatenated protein fasta file, used for blast
#argv[1] is a list of protein IDs, the genesForNR.txt file
#file prints, redirect the output to whatever output file desired
import re
import sys

protids = []

with open(sys.argv[2], 'r') as protidfile:
	for line in protidfile.readlines():
		protids.append(line)

compil_match = re.compile('^>')

with open(sys.argv[1], 'r') as seqidfile:
	for seqline in seqidfile:
		if any(pid in seqline for pid in protids):
			print(seqline, end="")
			for seqline in seqidfile:
				if re.match(compil_match, seqline) == None:
					print(seqline, end="")
				else:
					break


