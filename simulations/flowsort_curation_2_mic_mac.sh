#USAGE: command line input should look like $bash flowsort_curation_2_wc.sh 

#creates directories to store intermediate files 
mkdir -p sam_mic
mkdir -p bam_mic

#just type commands verbatim its just one set of reads not iterative

#aligns paired end fastqs to reference 
bwa mem /work/aahowel3/flowsortdata/2931489_Howell/fishers_rerun/mic_mac_combinedreference_rDNA.fasta mic_simulated1.fq mic_simulated2.fq > sam_mic/mic_simulated_tomicmac.sam
#converts sam to bam, sorts and indexes bam
samtools view -S -b sam_mic/mic_simulated_tomicmac.sam > bam_mic/mic_simulated_tomicmac.bam
samtools sort -o bam_mic/mic_simulated_tomicmac_sorted.bam bam_mic/mic_simulated_tomicmac.bam
samtools rmdup bam_mic/mic_simulated_tomicmac_sorted.bam bam_mic/mic_simulated_tomicmac_sorted_rmdup.bam
samtools index bam_mic/mic_simulated_tomicmac_sorted_rmdup.bam 
samtools view -h -b -F 4 bam_mic/mic_simulated_tomicmac_sorted_rmdup.bam > bam_mic/mic_simulated_tomicmac_sorted_rmdup_mapped.bam
samtools index bam_mic/mic_simulated_tomicmac_sorted_rmdup_mapped.bam


#creates directories to store intermediate files
mkdir -p sam_mac   
mkdir -p bam_mac   

#just type commands verbatim its just one set of reads not iterative

#aligns paired end fastqs to reference
bwa mem /work/aahowel3/flowsortdata/2931489_Howell/fishers_rerun/mic_mac_combinedreference_rDNA.fasta mac_simulated1.fq mac_simulated2.fq > sam_mac/mac_simulated_tomicmac.sam
#converts sam to bam, sorts and indexes bam
samtools view -S -b sam_mac/mac_simulated_tomicmac.sam > bam_mac/mac_simulated_tomicmac.bam
samtools sort -o bam_mac/mac_simulated_tomicmac_sorted.bam bam_mac/mac_simulated_tomicmac.bam
samtools rmdup bam_mac/mac_simulated_tomicmac_sorted.bam bam_mac/mac_simulated_tomicmac_sorted_rmdup.bam
samtools index bam_mac/mac_simulated_tomicmac_sorted_rmdup.bam
samtools view -h -b -F 4 bam_mac/mac_simulated_tomicmac_sorted_rmdup.bam > bam_mac/mac_simulated_tomicmac_sorted_rmdup_mapped.bam
samtools index bam_mac/mac_simulated_tomicmac_sorted_rmdup_mapped.bam


