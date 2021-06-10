#USAGE: command line input should look like $bash flowsort_curation_2_wc.sh 

#creates directories to store intermediate files 
mkdir -p sam
mkdir -p bam

#just type commands verbatim its just one set of reads not iterative

#aligns paired end fastqs to reference 
bwa mem /work/aahowel3/flowsortdata/2931489_Howell/fishers_rerun/mic_mac_combinedreference_rDNA.fasta wc_simulated1.fq wc_simulated2.fq > sam/wc_simulated_tomicmac.sam
#converts sam to bam, sorts and indexes bam
samtools view -S -b sam/wc_simulated_tomicmac.sam > bam/wc_simulated_tomicmac.bam
samtools sort -o bam/wc_simulated_tomicmac_sorted.bam bam/wc_simulated_tomicmac.bam
samtools rmdup bam/wc_simulated_tomicmac_sorted.bam bam/wc_simulated_tomicmac_sorted_rmdup.bam
samtools index bam/wc_simulated_tomicmac_sorted_rmdup.bam 

