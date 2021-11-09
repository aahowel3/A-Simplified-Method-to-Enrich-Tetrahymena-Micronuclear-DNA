#USAGE: command line input should look like $bash flowsort_curation_2_wc.sh *R1.trim.fq

#creates directories to store intermediate files 
mkdir -p ./fishers_exact_03/wholecell_subset/sam2
mkdir -p ./fishers_exact_03/wholecell_subset/bam2

for filename in $@
do
#strips extension from input file 
	file=$(basename "$filename" _R1.fq)
#aligns paired end fastqs to reference 
	bwa mem ./data_01/mic_mac_combinedreference_rDNA.fasta ./wholecell_data_02/"${file}"_R1.fq ./wholecell_data_02/"${file}"_R2.fq > ./fishers_exact_03/wholecell_subset/sam2/"${file}"_tomicmac.sam
#converts sam to bam, sorts and indexes bam
	samtools view -S -b ./fishers_exact_03/wholecell_subset/sam2/"${file}"_tomicmac.sam > ./fishers_exact_03/wholecell_subset/bam2/"${file}"_tomicmac.bam
	samtools sort -o ./fishers_exact_03/wholecell_subset/bam2/"${file}"_tomicmac_sorted.bam ./fishers_exact_03/wholecell_subset/bam2/"${file}"_tomicmac.bam
	samtools rmdup ./fishers_exact_03/wholecell_subset/bam2/"${file}"_tomicmac_sorted.bam ./fishers_exact_03/wholecell_subset/bam2/"${file}"_tomicmac_sorted_rmdup.bam
	samtools view -b -h -F 4 ./fishers_exact_03/wholecell_subset/bam2/"${file}"_tomicmac_sorted_rmdup.bam > ./fishers_exact_03/wholecell_subset/bam2/"${file}"_tomicmac_sorted_rmdup_mapped.bam
	samtools index ./fishers_exact_03/wholecell_subset/bam2/"${file}"_tomicmac_sorted_rmdup_mapped.bam 
done
