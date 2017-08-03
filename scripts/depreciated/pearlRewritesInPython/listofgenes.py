#!/usr/bin/python

import re
import sys

idPat = re.compile('^>lcl\|(.+_prot_[a-zA-Z0-9\._]+?)\s')

# re.compile('/\w+\|\w+[\.]*[\d]*_prot_(\w+[\.]*\w+)\t\d+\t\d+\t\d+\t\d+\t\w+[\.]*[\d]*_prot_(\w+[\.]*\w+)\t.+/')

with open(sys.argv[1],'r') as inpt, open(str(sys.argv[1]) + '.listofgenes.txt','w') as opt:
    for line in inpt.readlines():
        match = idPat.findall(line)
        if len(match) != 0 :
            for x in match:
                opt.write(str(x).replace('_prot_', '\t') + '\n')
            
inpt.close()
opt.close()

