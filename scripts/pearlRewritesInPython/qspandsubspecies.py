#!/usr/bin/python

import re
import sys

comment = re.compile('^# ')
sameHitPattern = re.compile('[lcl\|]*(\w+[\.]*[\d]*)_cdsid_(\w+[\.]*\w+)/$1\t$2')

with open(sys.argv[1],'r') as inpt, open(str(sys.argv[1]) + 'tabDelimited','w') as opt:
    for line in inpt.readlines():
        if comment.search(line) != None :
            opt.write(line) 
        else:
            splited = line.split('_prot_')
#            print '\t'.join(splited).replace('lcl|', '')
            opt.write('\t'.join(splited).replace('lcl|', ''))
inpt.close()
opt.close()
    
