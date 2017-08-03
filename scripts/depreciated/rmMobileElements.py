i#!/usr/local/bin/python3.5

import re
import sys

# argv[2] is a file with rgex patterns 
# argv[1] is the file to be filtered
# prints to stdout, just direct it to a desired opt file

with open(sys.argv[1], 'r') as fasta, open(sys.argv[2], 'r') as chkpatters:
    for seqline in fasta:
        if re.matc
