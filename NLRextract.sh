#!/bin/sh
######################################################### To get the script running
NLRextracthome=/Users/daniel/PostDoc/Programs/NLRextract
######################################################### and put the folder in PATH

NBARChmm=$NLRextracthome/hmm/NB-ARC_pfam.hmm
CChmm=$NLRextracthome/hmm/Rx_N.hmm
TIRhmm=$NLRextracthome/hmm/TIR_pfam.hmm
RPW8hmm=$NLRextracthome/hmm/RPW8_pfam.hmm
LRR=$NLRextracthome/hmm/LRR/LRR.hmm
MADA=$NLRextracthome/hmm/mada.hmm

plotNLR=$NLRextracthome/plotNLR.r
vennNLR=$NLRextracthome/vennNLR.r

if [ ! -z "$1" ]
  then
    wd=$(dirname $1)/
    in=$(basename -- "$1")
    echo $wd
    echo $in

    echo "NLR domain hmms:"
    echo ""
    echo $NBARChmm
    echo $CChmm
    echo $TIRhmm
    echo $RPW8hmm
    echo $LRR
    echo ""
    if [ $wd == '.' ]
    then
      touch $in.stats
      touch $in.stderr
    else
      touch $wd'nlr.stats'
      touch $wd'nlr.stderr'
    fi

    echo "# $(grep -E "^>" $wd$in | wc -l) sequences in multi fasta"


######################################################################################################################################################
# 1. Checking the whole dataset for NB-ARC, CC, TIR, RPW8 and LRR domains:
# searching the fa file for NB-ARC domain containing sequences:
    hmmsearch --max --tblout $wd'nb.out.tbl' -o $wd'nb.out' $NBARChmm $1 2>> $wd'nlr.stderr'

    grep -v "^#" $wd'nb.out.tbl' | awk '$5<0.01' | awk '{print $1}' > $wd'nb.out.seqname' 2>> $wd'nlr.stderr'

    echo "# $(wc -l < $wd'nb.out.seqname') sequences with NB-ARC domain"

    echo "NB-ARC\n$(cat $wd'nb.out.seqname')" > $wd'nb.out.name'

    echo "$(wc -l < $wd'nb.out.seqname')\tNB-ARC" >> $wd'nlr.stats'

    #awk -F'>' 'NR==FNR{ids[$0]; next} NF>1{f=($2 in ids)} f' $1.nb.out.seqname $1 > $1.nb.out.fa

# searching the fa file for CC domain containing sequences:
    hmmsearch --max --tblout $wd'cc.out.tbl' -o $wd'cc.out' $CChmm $1 2>> $wd'nlr.stderr'

    grep -v "^#" $wd'cc.out.tbl' | awk '$5<0.01' | awk '{print $1}' > $wd'cc.out.seqname' 2>> $wd'nlr.stderr'

    echo "# $(wc -l < $wd'cc.out.seqname') sequences with CC domain"

    echo "CC\n$(cat $wd'cc.out.seqname')" > $wd'cc.out.name'

    echo "$(wc -l < $wd'cc.out.seqname')\tCC" >> $wd'nlr.stats'

    #awk -F'>' 'NR==FNR{ids[$0]; next} NF>1{f=($2 in ids)} f' $input.cc.out.seqname $input > $input.cc.out.fa

# searching the fa file for TIR domain containing sequences:
    hmmsearch --max --tblout $wd'tir.out.tbl' -o $wd'tir.out' $TIRhmm $1 2>> $wd'nlr.stderr'

    grep -v "^#" $wd'tir.out.tbl' | awk '$5<0.01' | awk '{print $1}' > $wd'tir.out.seqname' 2>> $wd'nlr.stderr'

    echo "# $(wc -l < $wd'tir.out.seqname') sequences with TIR domain"

    echo "TIR\n$(cat $wd'tir.out.seqname')" > $wd'tir.out.name'

    echo "$(wc -l < $wd'tir.out.seqname')\tTIR" >> $wd'nlr.stats'

    #awk -F'>' 'NR==FNR{ids[$0]; next} NF>1{f=($2 in ids)} f' $input.tir.out.seqname $input > $input.tir.out.fa

# searching the fa file for RPW8 domain containing sequences:
    hmmsearch --max --tblout $wd'rpw8.out.tbl' -o $wd'rpw8.out' $RPW8hmm $1 2>> $wd'nlr.stderr'

    grep -v "^#" $wd'rpw8.out.tbl' | awk '$5<0.01' | awk '{print $1}' > $wd'rpw8.out.seqname' 2>> $wd'nlr.stderr'

    echo "# $(wc -l < $wd'rpw8.out.seqname') sequences with RPW8 domain"

    echo "RPW8\n$(cat $wd'rpw8.out.seqname')" > $wd'rpw8.out.name'

    echo "$(wc -l < $wd'rpw8.out.seqname')\tRPW8" >> $wd'nlr.stats'

    #awk -F'>' 'NR==FNR{ids[$0]; next} NF>1{f=($2 in ids)} f' $input.rpw8.out.seqname $input > $input.rpw8.out.fa

# searching the fa file for RPW8 domain containing sequences:
    hmmscan --max --tblout $wd'lrr.out.tbl' -o $wd'lrr.out' $LRR $1 2>> $wd'nlr.stderr'

    grep -v "^#" $wd'lrr.out.tbl' | awk '$5<0.01' | awk '{ print $3 }' | uniq  > $wd'lrr.out.seqname' 2>> $wd'nlr.stderr'

    echo "# $(wc -l < $wd'lrr.out.seqname') sequences with LRR domain"

    echo "LRR\n$(cat $wd'lrr.out.seqname')" > $wd'lrr.out.name'

    echo "$(wc -l < $wd'lrr.out.seqname')\tLRR" >> $wd'nlr.stats'

    #awk -F'>' 'NR==FNR{ids[$0]; next} NF>1{f=($2 in ids)} f' $input.lrr.out.seqname $input > $input.lrr.out.fa

    echo "#"

######################################################################################################################################################
# plot some stuff
    Rscript $vennNLR $wd'nb.out.name' $wd'cc.out.name' $wd'tir.out.name' $wd'rpw8.out.name' $wd'lrr.out.name' --save 2>> $wd'nlr.stderr'

    NLRprotein=$wd*.protein
    for f in $NLRprotein
    do
      echo $(basename -- "$f")
      echo "$(wc -l < $f)\t$(basename -- "$f")" >> $wd'nlr.stats'
      awk '{print $2}' $f > $wd'tmp'
      awk -F'>' 'NR==FNR{ids[$0]; next} NF>1{f=($2 in ids)} f' $wd'tmp' $1 > $f.fa
      rm $wd'tmp'
    done

    Rscript $plotNLR $wd'nlr.stats' --save 2>> $wd'nlr.stderr'

######################################################################################################################################################
# cleaning up the mess
    rand_folder=$(cat /dev/urandom | env LC_CTYPE=C tr -dc a-zA-Z0-9 | head -c 6; echo)

    mkdir $wd$rand_folder

    mkdir $wd$rand_folder'/seqname'

    SEQNAME=$wd'/'*.seqname
    echo "#  - Moving all files with sequence names to $rand_folder/seqname"
    for f in $SEQNAME
    do
      mv $f $wd$rand_folder'/seqname' 2>> $wd'nlr.stderr'
    done

    mkdir $wd$rand_folder'/fasta'
    FASTA=$wd'/'*.protein.fa
    echo "#  - Moving all fasta files to $rand_folder/fasta"
    for f in $FASTA
    do
      mv $f $wd$rand_folder'/fasta' 2>> $wd'nlr.stderr'
    done

    mkdir -p $wd$rand_folder'/hmmer' $wd$rand_folder'/hmmer/out'  $wd$rand_folder'/hmmer/tbl'

    FASTA=$wd'/'*.out
    echo "#  - Moving all .out files to $rand_folder/hmmer/out"
    for f in $FASTA
    do
      mv $f $wd$rand_folder'/hmmer/out' 2>> $wd'nlr.stderr'
    done

    FASTA=$wd'/'*.tbl
    echo "#  - Moving all .tbl files to $rand_folder/hmmer/tbl"
    for f in $FASTA
    do
      mv $f $wd$rand_folder'/hmmer/tbl' 2>> $wd'nlr.stderr'
    done

    mkdir $wd$rand_folder'/plot'
    FASTA=$wd'/'*.pdf
    echo "#  - Moving all .pdf files to $rand_folder/plot"
    for f in $FASTA
    do
      mv $f $wd$rand_folder'/plot' 2>> $wd'nlr.stderr'
    done

    FASTA=$wd'/'*.name
    echo "#  - Moving all .name files to $rand_folder/plot"
    for f in $FASTA
    do
      mv $f $wd$rand_folder'/plot' 2>> $wd'nlr.stderr'
    done
    echo "#  - Moving all .stats files to $rand_folder/plot"
    mv $wd'nlr.stats' $wd$rand_folder'/plot' 2>> $wd'nlr.stderr'

    FASTA=$wd'/'*.protein
    echo "#  - Moving all .protein files to /"$rand_folder
    for f in $FASTA
    do
      mv $f $wd$rand_folder 2>> $wd'nlr.stderr'
    done

    echo "#  - Moving files to /"$rand_folder
    mv $wd'nlr.prot' $wd$rand_folder 2>> $wd'nlr.stderr'
    mv $wd'nlr.stderr' $wd$rand_folder 2>> $wd'nlr.stderr'

  else
    echo "Nothing to do here."
    exit 1
fi
