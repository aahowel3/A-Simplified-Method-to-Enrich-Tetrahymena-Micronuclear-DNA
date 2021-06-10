# A-Simplified-Method-to-Enrich-Tetrahymena-Micronuclear-DNA

# Raw Data
in /data flowsort_curation.sh in runs trimmomatic on Mic and Mac pairs of fastq files and then fastqc on trimmmed files <br />
used TrueSeqv3 adapter trimming for illumina universal adapter

# Whole Cell Data
in /wholecell_data subset.sh creates a subset of reads from nonGE ancestors (Long et al., 2016) (BioProject PRJNA285268) with the same number of reads as the original Mic and Mac flowsorted sequencing samples

# Fisher's exact tests  
in /fishers_exact fishers_rerun_2.sh runs the MIC and MAC FACS against the combined refernece plus rDNA reference <br />
in /fishers_exact/wholecell_subset fishers_rerun_wc_2.sh reruns WC against the combined refernece plus rDNA reference <br />
unmapped reads removed with samtools view -b -h -F 4 file.bam > mapped.bam

# Simulations 
in /simulations the script wc_simulations.sh uses bamPEFragmentsize to estimate parameters for ART Illumina and then 2 seperate lines of ART Illumina commands sample reads from the MAC reference (45x) and MIC reference (2x). Mac and Mic R1 and Mac and Mic R2 are then concateneted togehter to create whole cell R1 simulation and whole cell R2 simulation - which is aligned to the MIC+MAC reference using the duplicatied script flowsortcuration_2_wc.sh <br />
unmapped reads removed with samtools view -b -h -F 4 file.bam > mapped.bam <br />

simulations run using MAC reference genome that had the mitochondria removed - to remove mito sequence from mac.genome.fasta use awk '{ if ((NR>1)&&($0~/^>/)) { printf("\n%s", $0); } else if (NR==1) { printf("%s", $0); } else { printf("\t%s", $0); } }' /storage/reference_genomes/tetrahymena_thermophila/mac/mac.genome.fasta | grep -v -Ff remove.txt - | tr "\t" "\n" > mac.genome_nomito.fasta

in /simulations_1x the script wc_simulations_1x.sh uses bamPEFragmentsize to estimate parameters for ART Illumina and then 2 seperate lines of ART Illumina commands sample reads from the MAC reference (45x) and MIC reference (2x).

# Coverage MDS and IES
IES_coordinates.csv - locations of IESs in supercontigs: https://doi.org/10.7554/eLife.19090.001 supplementary file 3A 

contig_to_chromosome.csv - locations of supercontigs in chromosomes: https://doi.org/10.7554/eLife.19090.001 supplementary file 1C

R script merge_contigs.R converts IES coordinates in supercontigs to IES coordinates in mic chromosomes. merge_contigs.R also splits the IESs_inmic_chromosomes into 5 files: chr#_IESs_inmic.tsv

in coverage/ coverage.sh creates 3 folders - mac_coverage, mic_coverage, wc_coverage - and creates a coverage file of mic samples, mac samples, and wc samples using Samtools depth, pulling from previously generated alignments - each folder has an analyze_coverage.sh - which is purely a way to loop each file back through to /coverage/analyze_coverage.R 

/coverage/analyze_coverage.R compares the IES_inMic file and the coverage file to calculate mean coverage for IES regions and mean coverage for Mac-destined regions

in coverage/ mac_coverage, mic_coverage, wc_coverage each folder ALSO has an analyze_coverage_allchromo.sh - which is purely a way to loop each file back through to /coverage/analyze_coverage_allchromo.R

analyze_coverage_allchromo.R compares the IES_inMic file and the coverage file to calculate mean coverage for IES regions and mean coverage for Mac-destined regions - but still seperated per chromosome - what is an IES in the coordinates for 1 chromosome will not be an IES at the same coordinates in another

analyze_coverage_allchromo.R produces the textfile wholechromo.samplename.text and calculates the mean coverage for IES regions and mean coverage for Mac-destined regions across all chromosomes 

# IRS 
in retention_scores/make_bedfile.sh takes retention_scores/chrX_IESs.tsv (tsv of the joined IES_in_supercontig.csv and contig_to_chromosome.csv made through merge_contigs.R) pulls out last 2 columns of chrX_IESs.tsv (IES_in_chr_start and IES_in_chr_end) and creates a bedfile of just those 4 columns - chr, IES_in_chr_start, IES_in_chr_end, and IES name (updated)

###updated so that the >names in the IES fasta file are now IESname_chrname_IES-inchr-startposition because there are duplicates IESs from supercontigs assembling to multiple places 

make_IESfasta.sh takes those bedfile positions and using bedtools getfasta and the micronucealr reference genome and pulls out all the basepairs in that bedfile range

IRSscore_alignment_2.sh aligns the Mac and Mic flowsorted samples to the mac+IES_reference.fasta reference and creates a bam folder

Rscript mic.mac.chain_perchromosome creates a chain file for each chromosome chain files 1-5 and mic_inIES files 1-5 are fed into create_mac_excisionsites.sh (which uses create_mac_excisionsites.R - this is what determines viable IESs - those not overlapping mac scaffolds) in pairs to create chrX_mac_excisionsites.tsvs for each chromosome

The script calculate_IRS.sh calcualtes the IRS+ and IRS- scores using samtools view startcoor:endcoor on bamfiles produced by IRSscore_alignment_2.sh while looping through the coordinates in the Chr_IESs_mac_excisionsites.tsvs to create the text files chrXIRSscores_mic.txt and chrX IRSscores_mac.txt Excision sites are truly just 1 or few bps - not a specific motfif or length 

#usage 
bash calculate_IRS_mac.sh chrX_IESs_mac_excisionsites.tsv > chrX_IESscores_macsample.txt 
bash calculate_IRS_mic.sh chrX_IESs_mac_excisionsites.tsv > chrX_IESscores_micsample.txt

calculateIRSscores.R then takes the chrXIRSscores_micsample.txt and chrX IRSscores_macsample.txt files to calculate the mean IRS scores for each sample and create a barplot of the IRS distribution

calculateIRSscores_all.R consolidates scores over all 5 chromosomes and graphs them in a histogram
