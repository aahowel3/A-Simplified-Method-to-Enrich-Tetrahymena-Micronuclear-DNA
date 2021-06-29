#USAGE: command line input should look like $bash flowsort_curation_2_wc.sh 

#creates directories to store intermediate files 
mkdir -p sam
mkdir -p bam

#aligns paired end fastqs to reference 
bwa mem /path/to/combined_reference wc_simulated1.fq wc_simulated2.fq > sam/wc_simulated_tomicmac.sam
#converts sam to bam, sorts and indexes bam
samtools view -S -b sam/wc_simulated_tomicmac.sam > bam/wc_simulated_tomicmac.bam
samtools sort -o bam/wc_simulated_tomicmac_sorted.bam bam/wc_simulated_tomicmac.bam
samtools rmdup bam/wc_simulated_tomicmac_sorted.bam bam/wc_simulated_tomicmac_sorted_rmdup.bam
samtools index bam/wc_simulated_tomicmac_sorted_rmdup.bam 

