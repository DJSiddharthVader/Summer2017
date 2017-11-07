#!/usr/local/bin/python3.5
#Author: Ann Le, McMaster University
#retrieves the sequences from a list of protIDs to create a fasta file for the oneway NR blast
#argv[1] is concatenated protein fasta file, used for blast
#argv[2] is a list of protein IDs, the genesForNR.txt file
#file prints, redirect the output to whatever output file desired
import re
import sys

protids = []

with open(sys.argv[2], 'r') as protidfile: # creates a python list of all the desired protein ids you want to get sequences for
    for line in protidfile.readlines():
        protids.append(line.strip())

compil_match = re.compile('^>') # matches headers in a fasta file

seq = open(sys.argv[1], 'r').readlines()

for i in range(len(seq)-2):
    if any(pid in seq[i] for pid in protids):
        for j in range(i,len(seq)-2):
            if re.match(compil_match, seq[j+1]) == None:
                print(seq[j], end = "") # all lines in the sequence except for last one
            else:
                print(seq[j], end="") # last line of sequence
                break



#with open(sys.argv[1], 'r') as seqidfile:
#    for seqline in seqidfile:
#        if any(pid in seqline for pid in protids): # if any of the protID are in the fasta header
#            print(seqline, end="")
#            for seqline in seqidfile: # print the sequence lines 
#                if re.match(compil_match, seqline) == None: #if the line is not a fasta header
#                    print(seqline, end = "")
#                else: # once you hit a fasta header
#                    break # break out of this loop and move onto the next seqline
