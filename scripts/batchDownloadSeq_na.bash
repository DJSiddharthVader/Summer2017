#!/bin/bash
source ~/.bashrc

# $1 is a file with all of the accession numbers 
ln=$(wc -l $1 | cut -f1)

cut -f1 $1 | sort -u > accnums.tmp

while read line;
do
    ~/summer2017/scripts/downloadseq_na.pl ${line}
done <accnums.tmp

rm accnums.tmp
#for (( i=1; i<=$ln; i++ ))
#do
#    fl $i $1 | xargs '/home/sid/summer2017/scripts/geneFamilyFiles/downloadseq_na.pl'
#done
