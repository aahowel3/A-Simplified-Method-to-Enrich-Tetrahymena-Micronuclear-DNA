#USAGE: command line input should look like $bash flowsort_curation_2_wc.sh /work/aahowel3/flowsortdata/2931489_Howell/wholecell_subset/*R1.trim.fq

#creates directories to store intermediate files 
mkdir -p sam2
mkdir -p bam2

for filename in $@
do
#strips extension from input file 
	file=$(basename "$filename" _R1.trim.fq)
#aligns paired end fastqs to reference 
	bwa mem /work/aahowel3/flowsortdata/2931489_Howell/fishers_rerun/mic_mac_combinedreference_rDNA.fasta /work/aahowel3/flowsortdata/2931489_Howell/wholecell_subset/"${file}"_R1.trim.fq /work/aahowel3/flowsortdata/2931489_Howell/wholecell_subset/"${file}"_R2.trim.fq > sam2/"${file}"_tomicmac.sam
#converts sam to bam, sorts and indexes bam
	samtools view -S -b sam2/"${file}"_tomicmac.sam > bam2/"${file}"_tomicmac.bam
	samtools sort -o bam2/"${file}"_tomicmac_sorted.bam bam2/"${file}"_tomicmac.bam
	samtools rmdup bam2/"${file}"_tomicmac_sorted.bam bam2/"${file}"_tomicmac_sorted_rmdup.bam
	samtools index bam2/"${file}"_tomicmac_sorted_rmdup.bam 

done
