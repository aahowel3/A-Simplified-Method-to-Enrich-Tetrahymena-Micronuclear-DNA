/work/aahowel3/bam2fastq/bam2fastq --no-aligned -o unaligned#.fastq ../../../bam/Mac_S2_L001_tomac_sorted_rmdup.bam 
spades.py -k 21,33,55,77,99,127 --careful -o spades_assembly -1 unaligned_1.fastq -2 unaligned_2.fastq
blastn -remote -db nr -query spades_assembly/contigs.fasta -evalue 1e-06 -show_gis -num_alignments 10 -num_descriptions 10 -out contigs.fasta.blastn
