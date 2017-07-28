#run using python3
import sys
from Bio import SeqIO

# argv[1] is a list of accnums to remove from a fasta file
# argv[2] is the fasta file to be filtered
# argv[3] is the output file title

#for accnum in open(sys.argv[1]).readlines():
#    print(str(accnum))


# print(open(sys.argv[1]).read())


#fasta = SeqIO.parse(sys.argv[2], "fasta") 
#
#with open(sys.argv[1], 'r') as torm, open(str(sys.argv[3]),'w+') as opt:
#    for rec in fasta:
#        if not (str(rec.id.split('|')[-1]) in torm.read()):
#            if not (str(rec.id.split('|')[-1]) in opt.read()):
#                SeqIO.write(rec, opt, "fasta")
