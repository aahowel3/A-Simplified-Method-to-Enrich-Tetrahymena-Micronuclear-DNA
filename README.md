# A-Simplified-Method-to-Enrich-Tetrahymena-Micronuclear-DNA

# Raw Data 01
Sequencing was performed using a MiSeq Reagent Kit Nano V2 (250 cycles) and Illumina paired-end sequenced by the DNASU core facility at the Biodesign Institute at Arizona State University. Samples were multiplexed with the final number of reads per sample being 1,048,024 reads for the MAC FACS sample and 904,282 reads for the MIC FACS sample. Sequencing reads are available from the NCBI’s SRA database under a BioProject with accession number PRJNA735576: https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA735576 <br />

./data_01/flowsort_curation_01a.sh in runs trimmomatic on Mic and Mac pairs of fastq files and then fastqc on trimmmed files <br />
used TrueSeqv3 adapter trimming for illumina universal adapter <br />
fastqc reports are in ./quality_control

# Whole Cell Data 02 
./wholecell_data_02/subset_02a.sh creates a subset of reads from nonGE ancestors (Long et al., 2016) (BioProject PRJNA285268) with the same number of reads as the original Mic and Mac flowsorted sequencing samples https://www.ncbi.nlm.nih.gov/bioproject/PRJNA285268/

# Reference Genomes 
MIC reference genome is available at: https://www.ncbi.nlm.nih.gov/assembly/GCA_000261185.1 <br />
MAC reference genome is available at: https://www.ncbi.nlm.nih.gov/assembly/GCA_000189635.1 <br />
rDNA reference genome is available at: https://www.ebi.ac.uk/ena/browser/view/X54512  <br />
to create the combined referenced concatenated the MIC, MAC, and rDNA references with "cat" 

# Fisher's exact tests 03
./fishers_exact_03/fishers_rerun_2_03a.sh runs the MIC and MAC FACS against the combined refernece plus rDNA reference <br />
./fishers_exact_03/wholecell_subset/flowsort_curation_wc_2_03b.sh reruns WC against the combined refernece plus rDNA reference <br />
unmapped reads removed with samtools view -b -h -F 4 file.bam > mapped.bam

In each alignment (MAC FACS to MICMAC ref and MIC FACS to MICMAC ref) the following commands are run: #count reads exclusively aligned to mac (scf) 
samtools view FACSsample_toconcatref_mapped.bam | grep -v "XA:" | grep -v "SA:" | awk '$3 ~ /scf/' | wc -l 
#count reads exclusively aligned to mic (chr) 
samtools view FACSsample_toconcatref_mapped.bam | grep -v "XA:" | grep -v "SA:" | awk '$3 ~ /chr/' | wc -l #can also run this command on mito (AF39)

Basic process has been to remove all reads that have an XA or an SA tag indicating a secondary or chimeric alignment.

R script for fishers test is ./fishers_exact/fishers_rerun_ftests_03c.R

# Simulations 04
simulations run using MAC reference genome had the mitochondria removed from the reference - to remove mito sequence from mac.genome.fasta use awk '{ if ((NR>1)&&($0~/^>/)) { printf("\n%s", $0); } else if (NR==1) { printf("%s", $0); } else { printf("\t%s", $0); } }' mac.genome.fasta | grep -v -Ff remove.txt - | tr "\t" "\n" > mac.genome_nomito.fasta

./simulations_04/wc_simulations_04a.sh uses bamPEFragmentsize to estimate parameters for ART Illumina and then 2 seperate lines of ART Illumina commands sample reads from the MAC reference (45x) and MIC reference (2x). Mac and Mic R1 and Mac and Mic R2 are then concateneted togehter to create whole cell R1 simulation and whole cell R2 simulation - which is aligned to the MIC+MAC reference using the script ./simulations/flowsortcuration_2_wc_04b.sh <br />
MIC only and MAC only simulations are run using ./simulations/flowsortcuration_2_mic_mac_04c.sh
unmapped reads removed with samtools view -b -h -F 4 file.bam > mapped.bam <br />


./simulations_1x/wc_simulations_1x_04d.sh uses bamPEFragmentsize to estimate parameters for ART Illumina and then 2 seperate lines of ART Illumina commands sample reads from the MAC reference (1x) and MIC reference (1x) which is aligned to the MIC+MAC reference using the script ./simulations_1x/flowsortcuration_2_wc_04e.sh

# Coverage MDS and IES 05
./coverage_05/IES_coordinates.csv - locations of IESs in supercontigs: https://doi.org/10.7554/eLife.19090.001 supplementary file 3A 

./coverage_05/contig_to_chromosome.csv - locations of supercontigs in chromosomes: https://doi.org/10.7554/eLife.19090.001 supplementary file 1C

The R script ./coverage_05/merge_contigs.R converts IES coordinates in supercontigs to IES coordinates in mic chromosomes. ./coverage_05/merge_contigs.R also splits the IESs_inmic_chromosomes into 5 files: chr#_IESs_inmic.tsv

in ./coverage_05/coverage.sh creates 3 folders - mac_coverage, mic_coverage, wc_coverage - and creates a coverage file of mic samples, mac samples, and wc samples using Samtools depth, pulling from previously generated alignments - each folder has an analyze_coverage_allchromo.sh - which is purely a way to loop each file back through to /coverage_05/analyze_coverage_allchromo.R 

./coverage_05/analyze_coverage_allchromo.R compares the IES_inMic file and the coverage file to calculate mean coverage for IES regions and mean coverage for Mac-destined regions - but seperated per chromosome - what is an IES in the coordinates for 1 chromosome will not be an IES at the same coordinates in another

# IRS 
./retention_scores_06/make_bedfile_06a.sh takes ./coverage_05/chrX_IESs.tsv (tsv of the joined IES_in_supercontig.csv and contig_to_chromosome.csv made through ./coverage_05/merge_contigs.R) pulls out last 2 columns of chrX_IESs.tsv (IES_in_chr_start and IES_in_chr_end) and creates a bedfile of just those 4 columns - chr, IES_in_chr_start, IES_in_chr_end, and IES name 

./retention_scores_06/make_IESfasta_06b.sh takes those bedfile positions and using bedtools getfasta and the micronucealr reference genome and pulls out all the basepairs in that bedfile range to create a MAC+IES reference 

./retention_scores_06/IRSscore_alignment_2_06c.sh aligns the Mac and Mic flowsorted samples to the mac+IES_reference.fasta reference and creates a bam folder

Rscript ./retention_scores_06/IRS/mic.mac.chain_perchromosome_06d.R creates a chain file for each chromosome 

Rscript ./retention_scores_06/IRS/create_mac_excisionsites_06e.sh takes chain files 1-5 and mic_inIES files 1-5 and loops them through create_mac_excisionsites_06f.R to create chrX_mac_excisionsites.tsvs for each chromosome

./retention_scores_06/IRS/calculate_IRS_mic_06g.sh and calculate_IRS_mac_06g.sh calcualtes the IRS+ and IRS- scores using samtools view startcoor:endcoor on bamfiles produced by IRSscore_alignment_2.sh while looping through the coordinates in the Chr_IESs_mac_excisionsites.tsvs to create the text files chrXIRSscores_mic.txt and chrX IRSscores_mac.txt Excision sites are truly just 1 or few bps - not a specific motfif or length 

./retention_scores_06/calculateIRSscores_all_06h.R consolidates scores over all 5 chromosomes and graphs them in a histogram

# Contamination 
./check_contamination_07/blast_check there is a mac_contamination and mic_contamination folder each with a blast_check_07a.sh that has the commands that convert unmapped reads in the bam to fastqs, assembles them with spades, and blasts them
