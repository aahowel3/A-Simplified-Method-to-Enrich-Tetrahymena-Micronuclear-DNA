#create a 1million read subset of a whole cell mic+mac sample (ancestor, not GE'd) to compare to our purified mic/mac sample
#R1 = ~500,000 R2 = ~500,000 (look at fastqc report of Mac and Mic TRIMMED in ./quality_control to see how many reads you need to sample)

seqtk sample -s100 ./wholecell_data_02/SRR15681625_1.fastq 500000 > ./wholecell_data_02/SB210E_subset_R1.fq 
seqtk sample -s100 ./wholecell_data_02/SRR15681625_2.fastq 500000 > ./wholecell_data_02/SB210E_subset_R2.fq




