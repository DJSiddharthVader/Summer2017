#!/bin/python
import sys
# this script was used on 'onlyNamesOnlyCRISPRSpecies.txt'
# finds all unique genus names from a list of genus species

file = str(sys.argv[1])
outfile = 'genusCRISPRNamesSet.txt'
with open(file, 'r') as inpt, open(outfile, 'w') as opt:
    nameslist = []
    for line in inpt.readlines():
        nameslist.append(line.strip().split(' ')[0])
    snames = set(nameslist)
    opt.write('#output from setSpecies.py')
    for x in snames:
        opt.write(x + '\n')

