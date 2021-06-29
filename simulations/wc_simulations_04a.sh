#generate whole cell reads that reflect 96% of reads come from the MAC (45/47) and 4% of reads come from the MIC (2/47)
#art_illumina requires an estimate of the mean and std of the FRAGMENT SIZE (NOT read length, NOT insert size) to run 
#estimate mean and std of fragment size from MAPPED bam file of WC to MIC/MAC reads 

#with those estimtes, run art_illumina  
art_illumina -i /path/to/combined_reference.fasta -p -na -l 250 -f 45 -m 457 -s 4882 -o mac_simulated

art_illumina -i /path/to/combined_reference.fasta -p -na -l 250 -f 2 -m 457 -s 4882 -o mic_simulated           


