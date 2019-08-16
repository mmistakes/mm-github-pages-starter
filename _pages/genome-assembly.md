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

[SPAdes](http://cab.spbu.ru/software/spades/) and [dipSPAdes](http://spades.bioinf.spbau.ru/release3.0.0/dipspades_manual.html) for highly polymorphic diploid genomes  
[Abyss](http://www.bcgsc.ca/platform/bioinfo/software/abyss)  
[MaSuRCA](http://www.genome.umd.edu/masurca.html)  
[Velvet](http://sepsis-omics.github.io/tutorials/modules/velvet/)  

### Reference Assisted Genome Assembly Tools
[H. Lischer](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5681816/) has published an excellent tool for reference assisted genome assembly. [Here](https://bitbucket.org/HeidiLischer/refguideddenovoassembly_pipelines/src/master/) is the bitbucket webpage containing her code. I have yet to get it to work, but someday I hope to.

[Platanus-allee](http://platanus.bio.titech.ac.jp/)  
[RECORD](https://sourceforge.net/projects/record-genome-assembler/files/)  
[Redundans](https://github.com/lpryszcz/redundans)  
[Ragout](https://github.com/fenderglass/Ragout)  
[AlignGraph](https://github.com/baoe/AlignGraph)  

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
