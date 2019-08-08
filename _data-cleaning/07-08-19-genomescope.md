---
title: "07-08-19 Estimation of Genome Characteristics using Jellyfish and Genomescope"
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
Estimate genome characteristics using Jellyfish and Genome Scope


### Jellyfish Commands

```
jellyfish count -C -m 21 -s 1000000000 -t 17 *.fq -o reads.jf
jellyfish histo -t 17 reads.jf > reads.histo
```

### Genomescope

Genomescope website can be found [here](http://qb.cshl.edu/genomescope/). The reads.histo file created by jellyfish is uploaded to the website. The parameters I used for genome scope were:
* kmer length: 250
* Read length: 300
* Max kmer coverage: 1000

A more indepth breakdown of how genomescope works and how to interpret the graphs can be found in the GenomeScope paper [Supplementary Notes and Figures](https://www.biorxiv.org/content/biorxiv/suppl/2017/02/28/075978.DC2/075978-1.pdf) 

### Results

{% include gallery %}

```
GenomeScope version 1.0
k = 250

property                      min               max               
Heterozygosity                0.238218%         0.242847%         
Genome Haploid Length         459,637,022 bp    460,845,699 bp    
Genome Repeat Length          92,298,629 bp     92,541,341 bp     
Genome Unique Length          367,338,393 bp    368,304,359 bp    
Model Fit                     94.8963%          96.7972%          
Read Error Rate               0.0317446%        0.0317446%    
```


#### Thoughts

Genomescope is estimating the genome size of *P. californicus* to be about 50-100 mb larger than the published estimates. Additionally, the genome hetereozygosity is a lot lower (~.24%) than its relative *Apostichopus japonicus* (1.59%). Hopefully this is true as it will make assembly a little easier. However, the QC graphs do show a bit of hetereozygosity as can be seen in the graphs having two maximums. Due to the larger than expected genome size, the coverage is a bit less than the ~100x I was aiming for. Hopefully that won't affect assembly too much. GC content is sitting at around 37% as estimated by fastqc and novogene, this is similar to the *A. japonicus* genome GC content. 

{% include figure image_path="/assets/images/genomescope/apostichopusjaponicus.png" caption="Genome statistics from  the paper [Zhang et al 2017](https://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.2003790)" %}


#### Model
```
Formula: y ~ (((2 * (1 - d) * (1 - (1 - r)^k)) + (2 * d * (1 - (1 - r)^k)^2) + 
    (2 * d * ((1 - r)^k) * (1 - (1 - r)^k))) * dnbinom(x, size = kmercov/bias, 
    mu = kmercov) * length + (((1 - d) * ((1 - r)^k)) + (d * 
    (1 - (1 - r)^k)^2)) * dnbinom(x, size = kmercov * 2/bias, 
    mu = kmercov * 2) * length + (2 * d * ((1 - r)^k) * (1 - 
    (1 - r)^k)) * dnbinom(x, size = kmercov * 3/bias, mu = kmercov * 
    3) * length + (d * (1 - r)^(2 * k)) * dnbinom(x, size = kmercov * 
    4/bias, mu = kmercov * 4) * length)

Parameters:
         Estimate Std. Error t value Pr(>|t|)    
d       6.758e-02  4.693e-03    14.4   <2e-16 ***
r       2.405e-03  1.157e-05   207.9   <2e-16 ***
kmercov 6.652e+01  4.367e-02  1523.1   <2e-16 ***
bias    1.871e+00  1.636e-02   114.3   <2e-16 ***
length  3.887e+08  1.338e+06   290.5   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 123200 on 966 degrees of freedom

Number of iterations to convergence: 7 
Achieved convergence tolerance: 2.511e-06
```


