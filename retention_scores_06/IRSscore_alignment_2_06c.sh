#align mic flowsort samples and mac flowsort samples to Mac + IESs references
#USAGE: command line input should look like $bash IRSscore_alignment.sh *R1_001.trim.fastq.gz

#creates directories to store intermediate files
#mkdir -p ./retention_scores_06/sam_IRS2
#mkdir -p ./retention_scores_06/bam_IRS2
bwa index ./retention_scores_06/mac_all+IES_reference.fasta

for filename in $@
do
#strips extension from input file
        file=$(basename "$filename" _1.trim.fastq)
#aligns paired end fastqs to reference
        bwa mem ./retention_scores_06/mac_all+IES_reference.fasta ./data_01/"${file}"_1.trim.fastq ./data_01/"${file}"_2.trim.fastq > ./retention_scores_06/sam_IRS2/"${file}"_tomac_all+IES.sam
#converts sam to bam, sorts and indexes bam
        samtools view -S -b ./retention_scores_06/sam_IRS2/"${file}"_tomac_all+IES.sam > ./retention_scores_06/bam_IRS2/"${file}"_tomac_all+IES.bam
        samtools sort -o ./retention_scores_06/bam_IRS2/"${file}"_tomac_all+IES_sorted.bam ./retention_scores_06/bam_IRS2/"${file}"_tomac_all+IES.bam
        samtools rmdup ./retention_scores_06/bam_IRS2/"${file}"_tomac_all+IES_sorted.bam ./retention_scores_06/bam_IRS2/"${file}"_tomac_all+IES_sorted_rmdup.bam
        samtools index ./retention_scores_06/bam_IRS2/"${file}"_tomac_all+IES_sorted_rmdup.bam
done

