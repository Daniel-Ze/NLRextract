![title](https://github.com/Daniel-Ze/NLRextract/blob/master/preview_nlrextract.png?raw=true)
# NLRextract: search for NLR related hmms

NLRextract was written to search for NLR related hmms in multi-fasta protein
sequences. It uses hmms from pfam v32. It includes the search for the CC domain related MADA motif [1]. This tool is under development so let me know if something's odd or can be improved. I tested the performance of NLRextract against [NLRparser](https://github.com/steuernb/NLR-Parser)[2] and [NLRtracker](https://github.com/slt666666/NLRtracker)[3] in a small article on my website: https://www.biotinkertech.eu/project_NLRextract.html


**IMPORTANT!! \

Potentially wrong output of NLRextract using system supplied awk: \
\
Filtering of hmmrsearch / hmmrscan output was so far done with the system supplied awk version. Standard Installation of Ubuntu 20.04 comes with mawk as awk version. This version of awk has problems with scientific notation of numbers. Therefore, gawk=5.1.0 was included in environment.yml and the bash script was 'NLRextract' was adjusted to use gawk for filtering of results. If you have run NLRextract on standard Ubuntu 20.04 please make sure to rerun your analysis with the updated version!!! \
\
IMPORTANT!!**

## What it does:

- Searching for: NB-ARC, CC, TIR, RPW8 and LRR domains in the proteins
- Create a venn diagram from the domain infromation
- Extract the overlaps of the different domain combinations
- Extract sequences of proteins with the different domain combinations
- Plot number of different domains, and number of different NLRs


## What it needs:

Please have a look at the environment.yml file for more information
```
(base) 💻 daniel:NLRextract $ cat environment.yml
```

## What it includes:

- NLRextract.sh -> Script to run hmmsearch, hmmscan and pltNLR.r/vennNLR.r
- vennNLR.r -> Create venn diagram from the domain infromation and extract the combinations
- plotNLR.r -> Create barplots for the domains and the NLR proteins

## How to install it:

1. Clone it
```shell
(base) 💻 daniel ~ $ git clone https://github.com/Daniel-Ze/NLRextract.git
```
3. put the containing folder in your $PATH
4. chmod a+x NLRextract
5. Edit line 3 in NLRextract if you chose to install it anywhere else than your home folder:
```shell
1 #!/bin/bash
2 ########################################################### To get the script running
3 NLRextracthome=~/NLRextract                               # edit this line
4 ########################################################### and put the folder in PATH
```
5. Install the environment:
```shell
(base) 💻 daniel ~ $ cd NLRextract
(base) 💻 daniel:NLRextract $ mamba env create -f environment.yml
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
	HMMs located in /Users/daniel/NLRextract/hmm/.
	Make sure that you supply a protein multifasta file.

Usage: NLRextract -p protein.fa
	-c number of CPUs to use (default: 1) 
	-p path to the protein multifasta (mandatory)
	-s suffix for folder (default: random string)
	-e conda environment (default: NLRextract)
```

## Output:
The script will generated several folder with the output of the different tools used:

```shell
NLRextract_TAIR10_test/
├── [3.1K]  nlr.stderr          # Error reports of all steps
├── [204K]  clust/              # Alignment and phylogenetic tree data
├── [ 92K]  domain/             # Fasta sequences of the extracted domains
├── [1.1M]  fasta/              # Fasta sequences of the extracted NLR proteins
├── [1.2M]  gff/                # GFF files of domains and NLR proteins
├── [233M]  hmmer/              # HMMER results for the NLR HMM motifs
├── [ 59K]  name/               # Sequence names of NLR proteins and domains
├── [ 26K]  seqname/            # Sequence names of proteins with a NLR domain
└── [ 34K]  stats/              # Summary of findings plus plots
```

## Changes:

**UPDATE 24.02.21**
  - switched from awk to gawk=5.1.0
 
**PREVIOUS UPDATES**
  - Added usage info
  - Added suffix and number of CPU options
  - Adjusted plotNLR.r output
  - Added phylogenetic trees

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.

[1] Hiroaki Adachi, Mauricio P Contreras, Adeline Harant, Chih-hang Wu, Lida Derevnina, Toshiyuki Sakai, Cian Duggan, Eleonora Moratto, Tolga O Bozkurt, Abbas Maqbool, Joe Win, Sophien Kamoun, 2019, An N-terminal motif in NLR immune receptors is functionally conserved across distantly related plant species. eLife, 8:e49956 http://dx.doi.org/10.7554/eLife.49956 \
[2] Burkhard Steuernagel,  Florian Jupe,  Kamil Witek, Jonathan D.G. Jones,  Brande B.H. Wulff, 2015, NLR-parser: rapid annotation of plant NLR complements. Bioinformatics, Vol. 31, Issue 10, Pages 1665–1667 https://doi.org/10.1093/bioinformatics/btv005 \
[3]  Jiorgos Kourelis,  Toshiyuki Sakai,  Hiroaki Adachi,  Sophien Kamoun, 2021, RefPlantNLR: a comprehensive collection of experimentally validated plant NLRs. bioRxiv, https://doi.org/10.1101/2020.07.08.193961 
