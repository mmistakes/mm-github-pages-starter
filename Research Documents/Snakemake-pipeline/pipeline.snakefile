rule fastq-list:
    input: "*.fq.gz"
    output: "list_files.txt"
    shell: "ls -1 {input} > {output}

rule kmergenie:
    input: "list_files.txt"
    output: "P_cali.{files}
    shell: "kmergenie {input} >> kmergenie_log.txt"

some_text_grabbing_code()
  open (kmergenie text file)
  return(ideal_kmer from last line)

kmer = some_text_grabbing_code()

rule Masurca_config:
    input: "config.txt"
    output: "assemble.sh"
    shell: "masurca {input}"


rule Abyss:
    input: "*_1.fq", "*_2.fq"
    output: {species}.{output}
    shell: "abyss-pe name={species} k=kmer in='{input}'

rule: Spades:
    input-1: "*_1.fq"
    input-2: "*_2.fq"
    output: "P_cali.{output}
    shell: "spades.py -1 {input-1} -2 {input-2} -o {directory}

