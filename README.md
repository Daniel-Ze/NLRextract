<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
# NLRextract: search for NLR related hmms

NLRextract was written to search for NLR related hmms in multi-fasta protein
sequences. It uses hmms from pfam v32. This tool is under development so let me know if something's odd or can be improved. I tested the performance of NLRextract against NLRparser and [https://github.com/slt666666/NLRtracker](NLRtracker) in a small article on my website: https://www.biotinkertech.eu/project_NLRextract.html

## What it does:

- Searching for: NB-ARC, CC, TIR, RPW8 and LRR domains in the proteins
- Create a venn diagram from the domain infromation
- Extract the overlaps of the different domain combinations
- Extract sequences of proteins with the different domain combinations
- Plot number of different domains, and number of different NLRs

## What it needs:

- conda with mamba
- bedtools
- clustalo
- clustalw2
- HMMER 3.2.1
  - hmmsearch
  - hmmscan
- Rscript
  - ggplot2
  - gplots
  - plyr
  - egg
  - cowplot

## What it includes:

- NLRextract.sh -> Script to run hmmsearch, hmmscan and pltNLR.r/vennNLR.r
- vennNLR.r -> Create venn diagram from the domain infromation and extract the combinations
- plotNLR.r -> Create barplots for the domains and the NLR proteins

## How to install it:

1. Clone it
2. put the condaining folder in your $PATH
3. chmod a+x NLRextract
4. Edit line 3 in NLRextract if you chose to install it anywhere else than your home folder:
```shell
1 #!/bin/bash
2 ########################################################### To get the script running
3 NLRextracthome=~/NLRextract                               # edit this line
4 ########################################################### and put the folder in PATH
```
5. Install the environment:
```shell
(base) 💻 daniel ~ $ cd NLRextract
(base) 💻 daniel:NLRextract $ mamba env install -f environment.yml
```

## How to run it:

```shell
(base) 💻 daniel:NLRextract $ NLRextract
/Users/daniel/miniconda3/etc/profile.d/conda.sh exists.
[info]	No conda environment name supplied. Defaulting to: NRLextract
[info]	Activating conda environment NLRextract:
[info]	 - Found Rscript in your path.
[info]	 - Found hmmsearch in your path.
[info]	 - Found bedtools in your path.
[error]	No protein file supplied.

	NLRextract will run hmmersearch and search for the
	HMMs located in /Users/daniel/test/hmm/.
	Make sure that supply a protein multifasta file.

Usage: NLRextract -p protein.fa
	-c number of CPUs to use (default: 1) 
	-p path to the protein multifasta (mandatory)
	-s suffix for folder (default: random string)
	-e conda environment (default: NLRextract)
```

## Changes:

- Added usage info
- Added suffix and number of CPU options
- Adjusted plotNLR.r output
- Added phylogenetic trees
