#!/bin/bash
# $1 is a fasta file without carriage returns
#converts from the output of pastebyalingmentline.sh to nexus format
echo $1
cat $1 | grep -c '^>[A-Za-z0-9\._]+\s'
ntax=$(grep -c '^>[A-Za-z0-9\._]+\s' $1)
echo $ntax;
nchar=temp;
echo -e 'Begin data;\n\tdimensions ntax='$ntax' nchar='$nchar';\n\tformat datatype=DNA interleave=no gap=-;\n\tmatrix;' > $(basename $1)'.nex';


#for i in `seq 2 $ntax`;
#do
#    cur_prot_name=$(grep -om'$i' '^>[A-Za-z0-9\._]+\s' $1 | tail 2 | head 1)
#    nxt_prot_name=$(grep -om'$i' '^>[A-Za-z0-9\._]+\s' $1 | tail 1)
#    prot_seq=$(awk '/${cur_prot_name}/{flag=1; next} /$nxt_prot_name/{flag=0} flag' $1 | paste -sd "")
#    echo $cur_prot_name $prot_seq >> $(basename $1)'.nex'
#done
