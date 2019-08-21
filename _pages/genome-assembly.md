---
title: "Genome Assembly"
permalink: /genomeassembly/
toc: true
toc_label: "Genome Assembly"
---

![image-left](/assets/images/gassembly.jpg){: .align-right width="500px" height="500px"} Sequencing a genome using sophisticated technology is only half of "Genome Sequencing". Current sequencing technology is capable of sequencing tiny fragments of the genome and assemblying those fragments into useable sequences is one of the primary challenges of genome sequencing. 

There are a number of different approaches including aligning the fragments against the genome of a closely related species, attempting to assembly the fragments without other information, and using multiple sequencing technologies and molecular techniques. These are respectively called "Reference based genome assembly", "*de novo* genome assembly", and "Hybrid genome assembly". 

Below are links to papers, tutorials, and software used for these various approaches. 

### Short Read Assembly Tools

[SPAdes](http://cab.spbu.ru/software/spades/) is an assembly toolkit containing various assembly pipelines. It works with Illumina or IonTorrent reads and is capable of providing hybrid assemblies using PacBio, Oxford Nanopore and Sanger reads. You can also provide additional contigs that will be used as long reads. [dipSPAdes](http://spades.bioinf.spbau.ru/release3.0.0/dipspades_manual.html) is a SPAdes version specifically for highly polymorphic diploid genomes. 

[Abyss](http://www.bcgsc.ca/platform/bioinfo/software/abyss) is a de novo, parallel, paired-end sequence assembler that is designed for short reads.  

[MaSuRCA](http://www.genome.umd.edu/masurca.html) is whole genome assembly software. It combines the efficiency of the de Bruijn graph and Overlap-Layout-Consensus (OLC) approaches. MaSuRCA can assemble data sets containing only short reads from Illumina sequencing or a mixture of short reads and long reads.  

[Velvet](http://sepsis-omics.github.io/tutorials/modules/velvet/) is an algorithm package that has been designed to deal with de novo genome assembly and short read sequencing alignments. This is achieved through the manipulation of de Bruijn graphs for genomic sequence assembly via the removal of errors and the simplification of repeated regions.  

### Reference Assisted Genome Assembly Tools
[H. Lischer](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5681816/) has published an excellent tool for reference assisted genome assembly. [Here](https://bitbucket.org/HeidiLischer/refguideddenovoassembly_pipelines/src/master/) is the bitbucket webpage containing her code. I have yet to get it to work, but someday I hope to.

[Platanus-allee](http://platanus.bio.titech.ac.jp/) is an assembler derived from Platanus assembler, however, it was developed with another concept. Platanus-allee tries to construct each haplotype sequence from the beginning and pair them as homologous chromosomes, while Platanus constructs consensus sequence of homologous chromosomes at first and tries to split into each haplotype sequence.    

[RECORD](https://sourceforge.net/projects/record-genome-assembler/files/) is a Reference-Assisted Genome Assembler for Closely Related Genomes  

[Redundans](https://github.com/lpryszcz/redundans) assists an assembly of heterozygous genomes.It takes as input assembled contigs, sequencing libraries and/or reference sequence and returns scaffolded homozygous genome assembly. Final assembly should be less fragmented and with total size smaller than the input contigs. In addition, Redundans will automatically close the gaps resulting from genome assembly or scaffolding.   

[Ragout](https://github.com/fenderglass/Ragout) is a tool for chromosome-level scaffolding using multiple references. Given initial assembly fragments (contigs/scaffolds) and one or multiple related references (complete or draft), it produces a chromosome-scale assembly (as a set of scaffolds). The approach is based on the analysis of genome rearrangements (like inversions or chromosomal translocations) between the input genomes and reconstructing the most parsimonious structure of the target genome.  

[AlignGraph](https://github.com/baoe/AlignGraph) is a software that extends and joins contigs or scaffolds by reassembling them with help provided by a reference genome of a closely related organism.  

[RGAAT](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6364042/) is a flexible toolkit for resequencing-based consensus building and annotation update.

### Bioninformatic Visualization Tools
[T. Reiter](https://taylorreiter.github.io/2019-05-11-Visualizing-NUCmer-Output/) has written some excellent tutorials. One I have used is using mummer4 to align genomes assemblies and then visualize the output in a circos plot. 

### Assembly Quality Analysis Tools

[Referee](https://gwct.github.io/referee/) is a program to calculate a quality score for every position in a genome assembly. This allows for easy filtering of low quality sites for any downstream analysis.

[Quast](http://quast.sourceforge.net/quast-lg.html) is a tool for evaluating genome assembly quality.

[Bandage](https://rrwick.github.io/Bandage/) is a program for visualising de novo assembly graphs. By displaying connections which are not present in the contigs file, Bandage opens up new possibilities for analysing de novo assemblies.

[Squat](https://github.com/luke831215/SQUAT) is a Sequencing Quality Assessment Tool for Data Assessments before and after Genome Assemblies

[GAAP](https://bigd.big.ac.cn/tools/gaap) is a cGOF (core-gene-defined Genome-organization-framework) Assisted Assembly Pipeline. It is aimed at scaffolding and extending scaffolds and contigs based on de novo assembly of one paired-end library and core gene cluster from multiple related references.

### Other Resources
[This](https://bioinformaticsworkbook.org/) is an excellent website containing information about genome QC, assembly, and annotation
