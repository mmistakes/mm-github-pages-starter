---
title: "Genome Assembly"
permalink: /genomeassembly/
toc: true
toc_label: "Genome Assembly"
toc_sticky: true
---

Sequencing a genome using sophisticated technology is only half of "Genome Sequencing". Current sequencing technology is capable of sequencing tiny fragments of the genome and assemblying those fragments into useable sequences is one of the primary challenges of genome sequencing. 

{% include figure image_path="assets/images/gassembly.jpg" %}

There are a number of different approaches including aligning the fragments against the genome of a closely related species, attempting to assembly the fragments without other information, and using multiple sequencing technologies and molecular techniques. These are respectively called "Reference based genome assembly", "*de novo* genome assembly", and "Hybrid genome assembly". 

Below are links to papers, tutorials, and software used for these various approaches. 

### Paper on how to do it
<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5681816/>

The scripts used in the paper
<https://bitbucket.org/HeidiLischer/refguideddenovoassembly_pipelines/src/master/>

### Bioninformatic Visualization Tools
Some info on visualizing output from Mummer4 alignmets
<https://taylorreiter.github.io/2019-05-11-Visualizing-NUCmer-Output/>

[This](https://bioinformaticsworkbook.org/) is an excellent website containing information about genome QC, assembly, and annotation

[Referee](https://gwct.github.io/referee/) is a program to calculate a quality score for every position in a genome assembly. This allows for easy filtering of low quality sites for any downstream analysis.

----

{% include feature_row %}

