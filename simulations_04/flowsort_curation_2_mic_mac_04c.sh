#USAGE: command line input should look like $bash flowsort_curation_2_wc.sh 

#creates directories to store intermediate files 
mkdir -p ./simulations_04/sam_mic
mkdir -p ./simulations_04/bam_mic

#just type commands verbatim its just one set of reads not iterative

#aligns paired end fastqs to reference 
bwa mem ./data_01/mic_mac_combinedreference_rDNA.fasta ./simulations_04/mic_simulated1.fq ./simulations_04/mic_simulated2.fq > ./simulations_04/sam_mic/mic_simulated_tomicmac.sam
#converts sam to bam, sorts and indexes bam
samtools view -S -b ./simulations_04/sam_mic/mic_simulated_tomicmac.sam > ./simulations_04/bam_mic/mic_simulated_tomicmac.bam
samtools sort -o ./simulations_04/bam_mic/mic_simulated_tomicmac_sorted.bam ./simulations_04/bam_mic/mic_simulated_tomicmac.bam
samtools rmdup ./simulations_04/bam_mic/mic_simulated_tomicmac_sorted.bam ./simulations_04/bam_mic/mic_simulated_tomicmac_sorted_rmdup.bam
samtools index ./simulations_04/bam_mic/mic_simulated_tomicmac_sorted_rmdup.bam 
samtools view -h -b -F 4 ./simulations_04/bam_mic/mic_simulated_tomicmac_sorted_rmdup.bam > ./simulations_04/bam_mic/mic_simulated_tomicmac_sorted_rmdup_mapped.bam
samtools index ./simulations_04/bam_mic/mic_simulated_tomicmac_sorted_rmdup_mapped.bam


#creates directories to store intermediate files
mkdir -p ./simulations_04/sam_mac   
mkdir -p ./simulations_04/bam_mac   

#aligns paired end fastqs to reference
bwa mem ./data_01/mic_mac_combinedreference_rDNA.fasta  ./simulations_04/mac_simulated1.fq ./simulations_04/mac_simulated2.fq > ./simulations_04/sam_mac/mac_simulated_tomicmac.sam
#converts sam to bam, sorts and indexes bam
samtools view -S -b ./simulations_04/sam_mac/mac_simulated_tomicmac.sam > ./simulations_04/bam_mac/mac_simulated_tomicmac.bam
samtools sort -o ./simulations_04/bam_mac/mac_simulated_tomicmac_sorted.bam ./simulations_04/bam_mac/mac_simulated_tomicmac.bam
samtools rmdup ./simulations_04/bam_mac/mac_simulated_tomicmac_sorted.bam ./simulations_04/bam_mac/mac_simulated_tomicmac_sorted_rmdup.bam
samtools index ./simulations_04/bam_mac/mac_simulated_tomicmac_sorted_rmdup.bam
samtools view -h -b -F 4 ./simulations_04/bam_mac/mac_simulated_tomicmac_sorted_rmdup.bam > ./simulations_04/bam_mac/mac_simulated_tomicmac_sorted_rmdup_mapped.bam
samtools index ./simulations_04/bam_mac/mac_simulated_tomicmac_sorted_rmdup_mapped.bam


