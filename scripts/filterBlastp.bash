#!/bin/bash
# $1 is the input blastp file, the file should be formated as such (space delimited):
#Fields: query id, query length, q. start, q. end, alignment length, subject id, subject length, % query coverage per subject, score, bit score, evalue
#this file removes all reciprocal hits (when the same gene is the subject and query) and all hits with less than 85% coverage from a blast file and spits them out to rmsamehits
\rm filter85reciprocal.blast

allline=$(wc -l $1 | cut -d' ' -f1) # number of lines in the file
echo $allline
for line in `seq 1 $allline`;
do
    curline=$(head -$line $1 | tail -1)
    num=$(echo $curline | cut -d' ' -f8)
    query=$(echo $curline | cut -d' ' -f1)
    subject=$(echo $curline | cut -d' ' -f6)
    if [[ $num  -ge 85 ]]
    then
        if [ "$subject" != "$query" ]
        then 
            echo $curline >> filter85reciprocal.blast   
        fi 
    fi
done
#    if [ "$(echo $curline | cut -f8)" -ge 85 ]
#    then
#        if [[ "$(echo $curline | cut -f1)" -eq "$(echo $curline |  cut -f6)" ]]
#        then 
#            echo $curline >> rmsamehits.blast
#        fi
#    fi

