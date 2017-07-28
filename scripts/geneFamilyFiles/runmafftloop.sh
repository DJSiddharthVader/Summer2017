#!/bin/bash
num=$(ls $1 | wc -l)
for a in `seq 1 $num`;
do
#echo "Gfagenome_ind_$a""seqs.fna"
    ~/src/mafft-linux64/mafft.bat --auto --quiet $1"Gfagenome_ind_$a""seqs.fna" > "Gfagenome_ind_$a""_aligned.fna" &
done
