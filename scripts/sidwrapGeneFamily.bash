#!/bin/bash

# wrapper script for the genefamily perl code because I always forget to grep the blast file first
# $2 is the blast file you want to get gene families from
# $1 is the name of the output file

grep -v '^#' $2 > blast.tmp
perl ~/summer2017/scripts/sidgenefamily11SplitSingletons.pl $1 blast.tmp 
\rm blast.tmp

mv genesForNR.txt nr.tmp
cut -d':' -f2 nr.tmp > genesForNR.txt
rm nr.tmp

./matchingprotid.py $2 genesForNR.txt > NRgenes.faa &
