#!/bin/bash

# $1 is the directory with the Gfagenome_ind_num files
# $2 is the Blast DB that is being checked against

for a in `seq 1 50`;
do
    blastdbcmd -db $2 -entry_batch $1"Gfagenome_ind_$a" > "Gfagenome_ind_$a""seqs.fna"
done





























#dbs=$(ls -d ~/summer2017/GeneFamilyCreation/NucleotideBlastDBs/* | cat)
#for db in $dbs;
#do
#    mkdir 
#    num=$(ls $db | wc -l)
#    for a in `seq 1 $num`; 
#    do
#        blastdbcmd -db $db -entry_batch "Gfagenome_ind_$a" > "Gfagenome_ind_$a""seqs.fna"
#    done
#done




##############ORIGINAL CODE BELOW###########################
#for a in `seq 1 50`; 
#do
#blastdbcmd -db ~/genefamily/genomes/myco_analysis/na_parsed10genomes -entry_batch "Gfagenome_ind_$a" > "Gfagenome_ind_$a""seqs.fna"
#done
