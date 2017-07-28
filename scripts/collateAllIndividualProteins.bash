#!/bin/bash
# this file is meant to take concat the contents of a bunch of protein ID files together so that it can be used for the genefamily11.R code
#$1 is the target directory
#$2 is the name of the outfile

rm $2

for file in $1/*;
do
    while read line;
    do
        acc=$(basename $file)
        echo -e "${acc:0:8}\t$line" >> $2
    done <$file
done
