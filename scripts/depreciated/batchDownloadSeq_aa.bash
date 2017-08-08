#!/usr/bin/bash
source ~/.bashrc

# fl is a custom command, it is just head -$i $1 | tail -1 where $i is a number and $1 is a file
# this command retrieves the i'ith line from the file

# the downloadseq_aa.pl file must be in the same directory as this file
# the input file $1 is a list of accession numbers for organisms, with each number on a different line

ln=$(wc -l $1 | cut -d' ' -f1)

for (( i=1; i<=$ln; i++ ))
do
    fl $i $1 | xargs 'downloadseq_aa.pl'
done
