#!/usr/bin/python

import re
import sys

comment = re.compile('^# ')
sameHitPattern = re.compile('(\_prot\_[a-zA-Z0-9\.\_]*?)\t')

# re.compile('/\w+\|\w+[\.]*[\d]*_prot_(\w+[\.]*\w+)\t\d+\t\d+\t\d+\t\d+\t\w+[\.]*[\d]*_prot_(\w+[\.]*\w+)\t.+/')

with open(sys.argv[1],'r') as inpt, open(str(sys.argv[1]) + 'filtSameHit.txt.','w') as opt:
    for line in inpt.readlines():
        if comment.search(line) != None :
            opt.write(line) 
        else:
            matched = sameHitPattern.split(line)
            if matched != None :
                if matched[1] != matched[3]:
                    opt.write(line)
#        else: 
#            matched = sameHitPattern.search(line)
#            if matched != None :
#                print line 
#                if matched.group(1) != matched.group(2):
#                    opt.write(line)
inpt.close()
opt.close()

