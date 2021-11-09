#USAGE: command line input should look like $bash flowsort_curation_2_wc.sh 

#creates directories to store intermediate files 
mkdir -p ./simulations_04/simulations_1x/sam
mkdir -p ./simulations_04/simulations_1x/bam

#aligns paired end fastqs to reference 
bwa mem ./data_01/mic_mac_combinedreference_rDNA.fasta ./simulations_04/simulations_1x/wc_simulated1.fq ./simulations_04/simulations_1x/wc_simulated2.fq > ./simulations_04/simulations_1x/sam/wc_simulated_tomicmac.sam
#converts sam to bam, sorts and indexes bam
samtools view -S -b ./simulations_04/simulations_1x/sam/wc_simulated_tomicmac.sam > ./simulations_04/simulations_1x/bam/wc_simulated_tomicmac.bam
samtools sort -o ./simulations_04/simulations_1x/bam/wc_simulated_tomicmac_sorted.bam ./simulations_04/simulations_1x/bam/wc_simulated_tomicmac.bam
samtools rmdup ./simulations_04/simulations_1x/bam/wc_simulated_tomicmac_sorted.bam ./simulations_04/simulations_1x/bam/wc_simulated_tomicmac_sorted_rmdup.bam
samtools view -b -h -F 4 ./simulations_04/simulations_1x/bam/wc_simulated_tomicmac_sorted_rmdup.bam > ./simulations_04/simulations_1x/bam/wc_simulated_tomicmac_sorted_rmdup_mapped.bam
samtools index ./simulations_04/simulations_1x/bam/wc_simulated_tomicmac_sorted_rmdup_mapped.bam 

