bash ./data_01/flowsort_curation_01a.sh ./data_01/*R1_001.fastq.gz

bash ./wholecell_data_02/subset_02a.sh /path/to/downloaded/wholecell_data

bash ./fishers_exact_03/fishers_rerun_2_03a.sh ./data_01/*R1_001.trim.fastq.gz

bash ./fishers_exact_03/wholecell_subset/flowsort_curation_wc_2_03b.sh ./data_01/*R1_001.trim.fastq.gz
samtools view -b -h -F 4 file.bam > mapped.bam
samtools view FACSsample_toconcatref_mapped.bam | grep -v "XA:" | grep -v "SA:" | awk '$3 ~ /scf/' | wc -l 
samtools view FACSsample_toconcatref_mapped.bam | grep -v "XA:" | grep -v "SA:" | awk '$3 ~ /chr/' | wc -l 

R ./fishers_exact_03/fishers_rerun_ftests_03c.R 
