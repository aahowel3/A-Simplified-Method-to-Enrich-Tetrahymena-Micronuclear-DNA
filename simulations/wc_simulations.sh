#generate whole cell reads that reflect 96% of reads come from the MAC (45/47) and 4% of reads come from the MIC (2/47)
#REMOVED MITO FROM MAC REF 

#art_illumina requires an estimate of the mean and std of the FRAGMENT SIZE (NOT read length, NOT insert size) to run 
#estimate mean and std of fragment size from MAPPED bam file of WC to MIC/MAC reads (no need to include fragment info from unmapped shit) 

#/work/aahowel3/deepTools/bin/bamPEFragmentSize -b /work/aahowel3/flowsortdata/2931489_Howell/fishers_rerun/wholecell_subset/bam/SB210E_subset_formic_tomicmac_sorted_rmdup_mapped.bam

#with those estimtes, run art_illumina  
/work/aahowel3/art_bin_MountRainier/art_illumina -i mac.genome_nomito.fasta -p -na -l 250 -f 45 -m 457 -s 4882 -o mac_simulated

/work/aahowel3/art_bin_MountRainier/art_illumina -i /storage/reference_genomes/tetrahymena_thermophila/mic/mic.genome.fasta -p -na -l 250 -f 2 -m 457 -s 4882 -o mic_simulated           


