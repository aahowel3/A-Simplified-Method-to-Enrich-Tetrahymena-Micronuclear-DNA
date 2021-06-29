#alignment of MIC and MAC facs samples to combined MIC/MAC reference for rerun of fishers exact tests 
#USAGE: command line input should look like $bash .sh ../*R1_001.trim.fastq.gz

#creates directories to store intermediate files 
mkdir -p sam2
mkdir -p bam2

for filename in $@
do
#strips extension from input file 
	file=$(basename "$filename" _R1_001.trim.fastq.gz)
#aligns paired end fastqs to reference 
	bwa mem mic_mac_combinedreference_rDNA.fasta ../"${file}"_R1_001.trim.fastq.gz ../"${file}"_R2_001.trim.fastq.gz > sam2/"${file}"_tomicmac.sam
#converts sam to bam, sorts and indexes bam
	samtools view -S -b sam2/"${file}"_tomicmac.sam > bam2/"${file}"_tomicmac.bam
	samtools sort -o bam2/"${file}"_tomicmac_sorted.bam bam2/"${file}"_tomicmac.bam
	samtools rmdup bam2/"${file}"_tomicmac_sorted.bam bam2/"${file}"_tomicmac_sorted_rmdup.bam
	samtools index bam2/"${file}"_tomicmac_sorted_rmdup.bam 
done

