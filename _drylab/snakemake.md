---
title: "Snakemake Test"
layout: single
---

### Snakemake file for running paired-end read merging and reference genome alignment of reads for parvimensis raw data to japonicus

```
rule seqprep:
	input: 
		first_in = "SRR1693446/SRR1693446_1.fastq.gz",
		second_in = "SRR1693446/SRR1693446_2.fastq.gz"
	output:
		merged = "Test/parv-merged.fasta.gz",
		first_out = "Test/dontcare/SRR1693446_1.merged.fastq.gz",
		second_out = "Test/dontcare/SRR1693446_2.merged.fastq.gz"
	shell:
		"SeqPrep -f {input.first_in} -r {input.second_in} -1 {output.first_out} -2 {output.second_out} -s {output.merged}"

rule nucmer:
	input:
		ref = "Apostichopusjaponicus/GCA_002754855.1_ASM275485v1/GCA_002754855.1_ASM275485v1_genomic.fasta",
		query = "Test/parv-merged.fasta"
	output:
		out = "Test/jap.parv"
	log:
		"logs/nucmer.log"	
	shell:
		"nucmer --mum {input.ref} {input.query} -p {output.out} -t 10" 

rule filterdelta:
	input:
		deltafile = "Test/jap.parv.delta"
	output:
		outfile = "Test/japparv.filter.delta"
	shell:
		"delta-filter -q {input.deltafile} > {output.outfile}"

rule showcoords:
	input:
		filterdelta = "Test/japparv.filter.delta"
	output:
		deltacoords = "Test/japparv.filter.coords.txt"
	shell:
		"show-coords -c -l -r -T {input.filterdelta} > {output.deltacoords}"
```

