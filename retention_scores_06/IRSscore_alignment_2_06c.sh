#align mic flowsort samples and mac flowsort samples to Mac + IESs references
#USAGE: command line input should look like $bash IRSscore_alignment.sh *R1_001.trim.fastq.gz

#creates directories to store intermediate files
mkdir -p sam_IRS2
mkdir -p bam_IRS2

for filename in $@
do
#strips extension from input file
        file=$(basename "$filename" _R1_001.trim.fastq.gz)
#aligns paired end fastqs to reference
        bwa mem retention_scores2/mac_all+IES_reference.fasta "${file}"_R1_001.trim.fastq.gz "${file}"_R2_001.trim.fastq.gz > sam_IRS2/"${file}"_tomac_all+IES.sam
#converts sam to bam, sorts and indexes bam
        samtools view -S -b sam_IRS2/"${file}"_tomac_all+IES.sam > bam_IRS2/"${file}"_tomac_all+IES.bam
        samtools sort -o bam_IRS2/"${file}"_tomac_all+IES_sorted.bam bam_IRS2/"${file}"_tomac_all+IES.bam
        samtools rmdup bam_IRS2/"${file}"_tomac_all+IES_sorted.bam bam_IRS2/"${file}"_tomac_all+IES_sorted_rmdup.bam
        samtools index bam_IRS2/"${file}"_tomac_all+IES_sorted_rmdup.bam
done

