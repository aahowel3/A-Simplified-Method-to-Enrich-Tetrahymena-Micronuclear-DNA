#alignment of MIC and MAC facs samples to combined MIC/MAC reference for rerun of fishers exact tests 
#removes unmapped reads for counting 

#creates directories to store intermediate files 
mkdir -p ./fishers_exact_03/sam2
mkdir -p ./fishers_exact_03/bam2

for filename in $@
do
#strips extension from input file 
	file=$(basename "$filename" _1.trim.fastq)
#aligns paired end fastqs to reference 
	bwa mem ./data_01/mic_mac_combinedreference_rDNA.fasta ./data_01/"${file}"_1.trim.fastq ./data_01/"${file}"_2.trim.fastq > ./fishers_exact_03/sam2/"${file}"_tomicmac.sam
#converts sam to bam, sorts and indexes bam
	samtools view -S -b ./fishers_exact_03/sam2/"${file}"_tomicmac.sam > ./fishers_exact_03/bam2/"${file}"_tomicmac.bam
	samtools sort -o ./fishers_exact_03/bam2/"${file}"_tomicmac_sorted.bam ./fishers_exact_03/bam2/"${file}"_tomicmac.bam
	samtools rmdup ./fishers_exact_03/bam2/"${file}"_tomicmac_sorted.bam ./fishers_exact_03/bam2/"${file}"_tomicmac_sorted_rmdup.bam
	samtools view -b -h -F 4 ./fishers_exact_03/bam2/"${file}"_tomicmac_sorted_rmdup.bam > ./fishers_exact_03/bam2/"${file}"_tomicmac_sorted_rmdup_mapped.bam
	samtools index ./fishers_exact_03/bam2/"${file}"_tomicmac_sorted_rmdup_mapped.bam
done

