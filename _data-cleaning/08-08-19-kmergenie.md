---
title: "08-08-19 Determination of Best k-mer for assembly"
toc: true
toc_sticky: true
author_profile: false
layout: single

gallery:
  - url: /assets/images/genomescope/plot.png
    image_path: /assets/images/genomescope/plot.png
    title: "Linear GenomeScope Profile"
    caption: "Linear GenomeScope Profile"
  - url: /assets/images/genomescope/plot.log.png
    image_path: /assets/images/genomescope/plot.log.png
    title: "Log GenomeScope Profile"
    caption: "Log GenomeScope Profile"  

---

## Purpose: 
Determine the ideal kmer for genome assembly

### Kmergenie
```
(base) jeilers@genomics1:/media/jeilers/Elements/P_cali_genome/Working Files$ ls -1 *.fq.gz > list_files
(base) jeilers@genomics1:/media/jeilers/Elements/P_cali_genome/Working Files$ kmergenie list_files --diploid -t 17 -o kmergenie_analysis
running histogram estimation
File list_files starts with character "P", hence is interpreted as a list of file names
Reading 2 read files
Linear estimation: ~36711 M distinct 71-mers are in the reads
K-mer sampling: 1/7002
| processing                                                                                         |
[going to estimate histograms for values of k: 121 111 101 91 81 71 61 51 41 31 21 
---------------------------------------------------------------------------------------------------------------------------------------------Total time Wallclock  63436.4 s
fitting model to histograms to estimate best k
could not fit kmergenie_analysis-k21.histo
estimation of the best k so far: 101
refining estimation around [95; 107], with a step of 2
running histogram estimation
File list_files starts with character "P", hence is interpreted as a list of file names
Reading 2 read files
Linear estimation: ~39949 M distinct 64-mers are in the reads
K-mer sampling: 1/7619
| processing                                                                                         |
[going to estimate histograms for values of k: 107 105 103 101 99 97 95 
---------------------------------------------------------------------------------------------------------------------------------------------Total time Wallclock  31747.2 s
fitting model to histograms to estimate best k
could not fit kmergenie_analysis-k21.histo
table of predicted num. of genomic k-mers: kmergenie_analysis.dat
recommended coverage cut-off for best k: 1
best k: 101
```

### Notes
It appears that the upper kmer limit for kmergenie is 121. Seeing as it found the ideal kmer to be 101, maybe that doesn't matter in this case, but I wonder. I should read more on it.


