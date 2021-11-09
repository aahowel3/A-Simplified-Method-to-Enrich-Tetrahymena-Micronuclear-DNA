#creates a coverage file of each sample (mic,mac,wc) mapped to mic reference 
#aligns the wc dataset to the mic ref -> coverage should be 64:4 ratio to mac-destined sequences vs. IESs

#need to generate alignments to only the MIC reference to see what aligned to MDS v IES regions
#command line usage bash ./coverage_05/coverage_05b.sh 
mkdir -p ./coverage_05/mic_alignments 
bwa index ./data_01/mic.genome.fasta

for filename in ./data_01/*_1.trim.fastq
do
#strips extension from input file
        file=$(basename "$filename" _1.trim.fastq)
	echo $file
#aligns paired end fastqs to reference
        bwa mem ./data_01/mic.genome.fasta ./data_01/"${file}"_1.trim.fastq ./data_01/"${file}"_2.trim.fastq > ./coverage_05/mic_alignments/"${file}"_tomicONLY.sam
#converts sam to bam, sorts and indexes bam
        samtools view -S -b ./coverage_05/mic_alignments/"${file}"_tomicONLY.sam > ./coverage_05/mic_alignments/"${file}"_tomicONLY.bam
        samtools sort -o ./coverage_05/mic_alignments/"${file}"_tomicONLY_sorted.bam ./coverage_05/mic_alignments/"${file}"_tomicONLY.bam
        samtools rmdup ./coverage_05/mic_alignments/"${file}"_tomicONLY_sorted.bam ./coverage_05/mic_alignments/"${file}"_tomicONLY_sorted_rmdup.bam
        samtools view -b -h -F 4 ./coverage_05/mic_alignments/"${file}"_tomicONLY_sorted_rmdup.bam > ./coverage_05/mic_alignments/"${file}"_tomicONLY_sorted_rmdup_mapped.bam
        samtools index ./coverage_05/mic_alignments/"${file}"_tomicONLY_sorted_rmdup_mapped.bam
done

#Wc alignments to MIC only 
for filename in ./wholecell_data_02/*R1.fq
do
#strips extension from input file
        file=$(basename "$filename" _R1.fq)
#aligns paired end fastqs to reference
        bwa mem ./data_01/mic.genome.fasta ./wholecell_data_02/"${file}"_R1.fq ./wholecell_data_02/"${file}"_R2.fq > ./coverage_05/mic_alignments/"${file}"_tomicONLY.sam
#converts sam to bam, sorts and indexes bam
        samtools view -S -b ./coverage_05/mic_alignments/"${file}"_tomicONLY.sam > ./coverage_05/mic_alignments/"${file}"_tomicONLY.bam
        samtools sort -o ./coverage_05/mic_alignments/"${file}"_tomicONLY_sorted.bam ./coverage_05/mic_alignments/"${file}"_tomicONLY.bam
        samtools rmdup ./coverage_05/mic_alignments/"${file}"_tomicONLY_sorted.bam ./coverage_05/mic_alignments/"${file}"_tomicONLY_sorted_rmdup.bam
        samtools view -b -h -F 4 ./coverage_05/mic_alignments/"${file}"_tomicONLY_sorted_rmdup.bam > ./coverage_05/mic_alignments/"${file}"_tomicONLY_sorted_rmdup_mapped.bam
        samtools index ./coverage_05/mic_alignments/"${file}"_tomicONLY_sorted_rmdup_mapped.bam
done


# -a is to include positions that include 0 coverage
samtools depth -a ./coverage_05/mic_alignments/SRR14745909_tomicONLY_sorted_rmdup_mapped.bam > ./coverage_05/Mac_tomic_coverage.txt 
awk '{print >> ($1 "_Mac_tomic_coverage.txt")}' ./coverage_05/Mac_tomic_coverage.txt
#Mac coverage by chromosome outputs need to be in the mac_coverage folder
mv *chr*Mac* ./coverage_05/mac_coverage/ 

samtools depth -a ./coverage_05/mic_alignments/SRR14745910_tomicONLY_sorted_rmdup_mapped.bam > ./coverage_05/Mic_tomic_coverage.txt 
awk '{print >> ($1 "_Mic_tomic_coverage.txt")}' ./coverage_05/Mic_tomic_coverage.txt
mv *chr*Mic* ./coverage_05/mic_coverage/

samtools depth -a ./coverage_05/mic_alignments/SB210E_subset_tomicONLY_sorted_rmdup_mapped.bam > ./coverage_05/SB210_tomic_coverage.txt 
awk '{print >> ($1 "_SB210_tomic_coverage.txt")}' ./coverage_05/SB210_tomic_coverage.txt
mv *chr*SB210* ./coverage_05/wc_coverage/
