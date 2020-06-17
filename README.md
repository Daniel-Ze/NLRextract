# NLRextract: search for NLR related hmms

NLRextract was written to search for NLR related hmms in multi-fasta protein
sequences. It uses hmms from pfam v32. This tool is under development so let me know if something's odd or can be improved.

## What it does:

- Searching for: NB-ARC, CC, TIR, RPW8 and LRR domains in the proteins
- Create a venn diagram from the domain infromation
- Extract the overlaps of the different domain combinations
- Extract sequences of proteins with the different domain combinations
- Plot number of different domains, and number of different NLRs

## What it needs:

- HMMER 3.2.1
  - hmmsearch
  - hmmscan
- Rscript
  - ggplot2
  - gplots

## What it includes:

- NLRextract.sh -> Script to run hmmsearch, hmmscan and pltNLR.r/vennNLR.r
- vennNLR.r -> Create venn diagram from the domain infromation and extract the combinations
- plotNLR.r -> Create barplots for the domains and the NLR proteins

## How to run it:

- Clone it
- put it in your PATH
- chmod a+x NLRextract.sh
- Write: NLRextract.sh protein.fa

## Changes:

- Added usage info
- Added suffix and number of CPU options
- Adjusted plotNLR.r output
