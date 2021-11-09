#generate whole cell reads that reflect 96% of reads come from the MAC (45/47) and 4% of reads come from the MIC (2/47)
#art_illumina requires an estimate of the mean and std of the FRAGMENT SIZE (NOT read length, NOT insert size) to run 

#estimate mean and std of fragment size from MAPPED bam file of WC to MIC/MAC reads 
#bamPEFragmentSize -b ./fishers_exact_03/wholecell_subset/bam2/SB210E_subset_tomicmac_sorted_rmdup_mapped.bam

#with those estimtes, run art_illumina  
/work/aahowel3/art_bin_MountRainier/art_illumina -i ./data_01/1-upd-Genome-assembly.fasta -p -na -l 250 -f 1 -m 16549 -s 436401 -o ./simulations_04/simulations_1x/mac_simulated

/work/aahowel3/art_bin_MountRainier/art_illumina -i ./data_01/mic.genome.fasta -p -na -l 250 -f 1 -m 16549 -s 436401 -o ./simulations_04/simulations_1x/mic_simulated           

cat ./simulations_04/simulations_1x/mac_simulated1.fq ./simulations_04/simulations_1x/mic_simulated1.fq > ./simulations_04/simulations_1x/wc_simulated1.fq

cat ./simulations_04/simulations_1x/mac_simulated2.fq ./simulations_04/simulations_1x/mic_simulated2.fq > ./simulations_04/simulations_1x/wc_simulated2.fq
