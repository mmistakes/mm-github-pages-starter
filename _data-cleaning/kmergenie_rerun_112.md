---
title: "22-08-19 Recompile kmergenie and kmergenie run with higher max kmer value"
layout: single
---

## Purpose
Determine best kmer for genome assembly

completed: 22-08-19 

### Background and Results
Kmergenie has a kmer size cutoff at 127 bp. This doesn't work well when using reads which are significantly longer than 127 base pairs. In my case, the read length is 150, paired end. In order to run kmergenie on longer reads, it has to be recompiled with a the kmer size set to a larger number. This required downloading the conda recipe used to build the bioconda kmergenie that I used previously. I then set the max kmer size to 300 in the bash make script and removed a few dependencies in the yaml file which were preventing the build from completing. I then compiled and installed the new version.  

I then ran the new kmergenie build using the illumina data with max kmer set to 280. This was a bad choice as all the kmers that were checked were even and this greatly increased the run time of program from a day or two to over a week. I would include a link backing this up, but I can't seem to find one at the moment.   

 *Predicted best kmer was 112*

### Figures
{% include figure image_path="/assets/images/kmergenie/112/best-k.png" caption="kmer distribution in data. Predicted Best kmer value denoted by red dashed line." %}  
{% include figure image_path="/assets/images/kmergenie/112/model.png"  caption="Model curve placed over data showing how well it fits the kmer distribution" %}  



