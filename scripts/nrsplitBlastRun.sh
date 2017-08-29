#!/bin/bash

#splits a .faa file into sub components, runs blasts on each subfile against nr database
# required bc numthreads arg doessnt work on blast (idk why)
# $1 is an input .faa file to be blasted

#if [ "$2" != ""  ]  # if arg 2 is passed
#then
#    subFileSize=$2 # each subfile is of size $2
#else
#    subFileSize=50 # subfile will be of size 50 by default if no $2 passed
#fi

nhead=$(grep -c '^>' $1) # number of headers in total fasta file
echo -e 'possible subfile sizes' 
facl=$(printf %.0f $(echo "sqrt($nhead)" | bc)) # sqrt nhead, upper bound of factors for nhead

for i in $(seq 1 $facl) #for every possible factor
do
    [ $(( $nhead / $i * $i)) == $nhead ] && echo "$(( $nhead / $i ))    $i" 
    #check if a valid factor and print it along with $i
done

echo 'please input desired file size (left colum): '
read subFileSize
echo 'input number of files (matching value in right colum): '
read nfile


grep -n '^>' $1 > linenums.tmp # headers of all the fasta entries

for i in $(seq 1 $nfile)
do
    hn=$(head -"$(( $i * $subFileSize - 1 ))" linenums.tmp | tail -1 )
    tt=$(wc -l $1)
    tl=$(head -"$(echo $tt - (($i * $subFileSize) - ($i - 1) * $subFileSize) - 1 | bc)" linenums.tmp | tail -1 )
    head -"$hn" $1 | tail -"$tl" > "$i"'subFile'`basename $1`
done


#for i in $(seq 1 $nfile)
#do
##    echo $(( $subFileSize * $i ))
#    head -"$(( $subFileSize * $i ))" heads.tmp | tail -"$subFileSize" > SFShead.tmp
#    ~/summer2017/scripts/matchingprotid.py $1 SFShead.tmp > "$i"'sub'`basename $1`
#    \rm SFShead.tmp
#done
#\rm heads.tmp
