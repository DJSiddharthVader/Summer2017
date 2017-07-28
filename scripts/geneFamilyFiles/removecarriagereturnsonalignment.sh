#!/bin/bash
num=$(ls $1 | wc -l)
for a in `seq 1 $num`;
do
#echo "Gfagenome_ind_$a""seqs.fna"
    perl -p -i -e 's/\r\n$/\n/g' $1"Gfagenome_ind_$a""_aligned.fna" &
done
