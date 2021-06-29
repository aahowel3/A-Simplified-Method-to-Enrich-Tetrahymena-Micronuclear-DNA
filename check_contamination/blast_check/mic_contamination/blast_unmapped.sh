#convert unaligned reads in MIC_to_micreference to fastqs
bam2fastq --no-aligned -o unaligned#.fastq Mic_S1_L001_tomic_sorted_rmdup.bam
#assemble into contigs
spades.py -k 21,33,55,77,99,127 --careful -o spades_assembly -1 unaligned_1.fastq -2 unaligned_2.fastq
#blast assembled contigs 
blastn -remote -db nr -query spades_assembly/contigs.fasta -evalue 1e-06 -show_gis -num_alignments 10 -num_descriptions 10 -out contigs.fasta.blastn
