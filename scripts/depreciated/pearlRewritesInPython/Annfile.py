#!/usr/bin/python

import re
import sys

comment = re.compile('ACCESSION\s+.+$ ')
with open(sys.argv[1], 'r') as inpt, open(str((sys.argv[1])) + 'filt85.txt.',  'w') as output:
    for line in inpt.readlines():
        if comment.search(line) != None:
            output.write(line)
        else:
            fields = re.split(r'\t+', line.strip())
            if int(fields[7]) >= 85:
                output.write(line)
inpt.close()
output.close()
