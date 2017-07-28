#!/bin/bash
num=$(ls $1 | wc -l)
for i in `seq 1 $num`;
do
    echo  $1"Gfagenome_ind_"$i"_aligned.fnawocr"
    paste -d "" $1"Gfagenome_ind_"$i"_aligned.fnawocr" >> $(basename $1)concatenatedalignment.fna
done

