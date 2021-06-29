#creates a coverage file of each sample (mic,mac,wc) mapped to mic reference 
#aligns the wc dataset to the mic ref -> coverage should be 47(45+2)/2 ratio to mac-destined sequences vs. IESs

# -a is to include positions that include 0 coverage
samtools depth -a Mac_S2_L001_tomic_sorted_rmdup.bam > Mac_tomic_coverage.txt 
awk '{print >> ($1 "_Mac_tomic_coverage.txt")}' Mac_tomic_coverage.txt

samtools depth -a Mic_S1_L001_tomic_sorted_rmdup.bam > Mic_tomic_coverage.txt 
awk '{print >> ($1 "_Mic_tomic_coverage.txt")}' Mic_tomic_coverage.txt

samtools depth -a SB210_tomic_sorted_rmdup.bam > SB210_tomic_coverage.txt 
awk '{print >> ($1 "_SB210_tomic_coverage.txt")}' SB210_tomic_coverage.txt



