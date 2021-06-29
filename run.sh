bash ./data_01/flowsort_curation_01a.sh ./data_01/*R1_001.fastq.gz

bash ./wholecell_data_02/subset_02a.sh /path/to/downloaded/wholecell_data

bash ./fishers_exact_03/fishers_rerun_2_03a.sh ./data_01/*R1_001.trim.fastq.gz

bash ./fishers_exact_03/wholecell_subset/flowsort_curation_wc_2_03b.sh ./data_01/*R1_001.trim.fastq.gz

R ./fishers_exact_03/fishers_rerun_ftests_03c.R 
