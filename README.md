# An-Alternative-Method-to-Enrich-Tetrahymena-Micronuclear-DNA

Previous estimations of the mutation rate of T. thermophila (Long et al., [2013](https://pubmed.ncbi.nlm.nih.gov/23934880/); Long et al., [2016](https://academic.oup.com/gbe/article/8/12/3629/2669853)) were calculated indirectly, potentially missing mutations that could explain the significant fitness decline of the MA lines. Through flow cytometry, we have demonstrated a method for micronuclei enrichment to directly estimate the mutation rate. Using sequencing reads from flow sorted samples and whole cell controls, we have validated sorting through the following statistical methods: (1) Fisher’s exact tests of uniquely mapped reads to the micro and macronuclear reference genomes (2) mean coverage depth of IES and Macronuclear-destined regions after alignment to the micronuclear reference genome (3) IES retention scores per FACS sample. Using sequencing data from flow-sorted micronuclei, we will be able to more accurately characterize complex mutation events (insertions, deletions, and copy number variants).

# Overview 
Each folder can be run in order 01-07 with scripts labeled a-h per folder, command line usage for each script is documented in run.sh in ./ <br />
run.sh downloads raw data as well as whole cell sample controls and creates concatenated reference genomes of the 
* MIC (http://datacommons.cyverse.org/browse/iplant/home/rcoyne/public/tetrahymena/MIC, 
* MAC (Tetrahymena Genome Database http://ciliate.org/)
* and mitochondrial (NCBI Reference Sequence: NC_003029.1) 

### Dependencies 
* R-3.6.3 https://cran.r-project.org/bin/windows/base/old/3.6.3/ 
* trimmomatic v0.38 http://www.usadellab.org/cms/?page=trimmomatic
* BWA mem v0.7.12 http://bio-bwa.sourceforge.net/
* SAMtools v1.10 http://www.htslib.org/
* seqtk https://github.com/lh3/seqtk
* ART (v1.5.0) https://www.niehs.nih.gov/research/resources/software/biostatistics/art/index.cfm
* deepTools bamPEFragmentSize https://deeptools.readthedocs.io/en/develop/content/tools/bamPEFragmentSize.html 
* transanno https://github.com/informationsea/transanno 
* minimap2 https://github.com/lh3/minimap2

# Raw Data 01
Sequencing was performed using a MiSeq Reagent Kit Nano V2 (250 cycles) and Illumina paired-end sequenced by the DNASU core facility at the Biodesign Institute at Arizona State University. Samples were multiplexed with the final number of reads per sample being 1,048,024 reads for the MAC FACS sample and 904,282 reads for the MIC FACS sample. Sequencing reads are available from the NCBI’s SRA database under a BioProject with accession number PRJNA735576: https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA735576 <br />

./data_01/flowsort_curation_01a.sh runs trimmomatic on Mic and Mac pairs of fastq files and then fastqc on trimmmed files <br />
used TrueSeqv3 adapter trimming for illumina universal adapter <br />
fastqc reports are in ./quality_control

# Whole Cell Data 02 
./wholecell_data_02/subset_02a.sh creates a subset of reads from nonGE ancestors (Long et al., 2016) (BioProject PRJNA285268) with the same number of reads as the original Mic and Mac flowsorted sequencing samples https://www.ncbi.nlm.nih.gov/bioproject/PRJNA285268/

# Fisher's exact tests 03
./fishers_exact_03/fishers_rerun_2_03a.sh runs the MIC and MAC FACS against the combined refernece plus rDNA reference <br />
./fishers_exact_03/wholecell_subset/flowsort_curation_wc_2_03b.sh reruns WC against the combined refernece plus rDNA reference <br />
unmapped reads removed with samtools view -b -h -F 4 file.bam > mapped.bam
./fishers_exact/fishers_rerun_count_03c.1.sh reports proportion of FACS sample reads mapped uniquely to each reference genome 
./fishers_exact/fishers_rerun_ftests_03c.R is the R script for fishers exact tests of uniquely mapped reads 

# Simulations 04
./simulations_04/wc_simulations_04a.sh uses bamPEFragmentsize to estimate parameters for ART Illumina and then 2 seperate lines of ART Illumina commands sample reads from the MAC reference (45x) and MIC reference (2x). Mac and Mic R1 and Mac and Mic R2 are then concateneted togehter to create whole cell R1 simulation and whole cell R2 simulation - which is aligned to the MIC+MAC reference using the script ./simulations/flowsortcuration_2_wc_04b.sh <br />
MIC only and MAC only simulations are run using ./simulations/flowsortcuration_2_mic_mac_04c.sh

./simulations_1x/wc_simulations_1x_04d.sh uses bamPEFragmentsize to estimate parameters for ART Illumina and then 2 seperate lines of ART Illumina commands sample reads from the MAC reference (1x) and MIC reference (1x) which is aligned to the MIC+MAC reference using the script ./simulations_1x/flowsortcuration_2_wc_04e.sh

# Coverage MDS and IES 05
./coverage_05/IES_coordinates.csv - locations of IESs in supercontigs: https://doi.org/10.7554/eLife.19090.001 supplementary file 3A 

./coverage_05/contig_to_chromosome.csv - locations of supercontigs in chromosomes: https://doi.org/10.7554/eLife.19090.001 supplementary file 1C

The R script ./coverage_05/merge_contigs_05a.R converts IES coordinates in supercontigs to IES coordinates in mic chromosomes. ./coverage_05/merge_contigs.R also splits the IESs_inmic_chromosomes into 5 files: chr#_IESs_inmic.tsv

in ./coverage_05/coverage_05b.sh performs alignments to MIC only reference then creates 3 folders - mac_coverage, mic_coverage, wc_coverage - and creates a coverage file of mic samples, mac samples, and wc samples using Samtools depth - each folder has an analyze_coverage_allchromo.sh - which is purely a way to loop each file back through to /coverage_05/analyze_coverage_allchromo.R 

./coverage_05/analyze_coverage_allchromo.R compares the IES_inMic file and the coverage file to calculate mean coverage for IES regions and mean coverage for Mac-destined regions - but seperated per chromosome - what is an IES in the coordinates for 1 chromosome will not be an IES at the same coordinates in another

# IRS 06
./retention_scores_06/make_bedfile_06a.sh takes ./coverage_05/chrX_IESs.tsv (tsv of the joined IES_in_supercontig.csv and contig_to_chromosome.csv made through ./coverage_05/merge_contigs.R) pulls out last 2 columns of chrX_IESs.tsv (IES_in_chr_start and IES_in_chr_end) and creates a bedfile of just those 4 columns - chr, IES_in_chr_start, IES_in_chr_end, and IES name 

./retention_scores_06/make_IESfasta_06b.sh takes those bedfile positions and using bedtools getfasta and the micronucealr reference genome and pulls out all the basepairs in that bedfile range to create a MAC+IES reference 

./retention_scores_06/IRSscore_alignment_2_06c.sh aligns the Mac and Mic flowsorted samples to the mac+IES_reference.fasta reference and creates a bam folder

./retention_scores_06/create_chain_06c_d.sh (new step in between c and d) creates a mic.mac chain file 

Rscript ./retention_scores_06/IRS/mic.mac.chain_perchromosome_06d.R creates a chain file for each chromosome  

Rscript ./retention_scores_06/IRS/create_mac_excisionsites_06e.sh takes chain files 1-5 and mic_inIES files 1-5 and loops them through create_mac_excisionsites_06f.R to create chrX_mac_excisionsites.tsvs for each chromosome

./retention_scores_06/IRS/calculate_IRS_mic_06g.sh and calculate_IRS_mac_06g.sh calcualtes the IRS+ and IRS- scores using samtools view startcoor:endcoor on bamfiles produced by IRSscore_alignment_2.sh while looping through the coordinates in the Chr_IESs_mac_excisionsites.tsvs to create the text files chrXIRSscores_mic.txt and chrX IRSscores_mac.txt Excision sites are truly just 1 or few bps - not a specific motfif or length 

./retention_scores_06/calculateIRSscores_all_06h.R consolidates scores over all 5 chromosomes and graphs them in a histogram

# Contamination 07
./check_contamination_07/blast_check there is a mac_contamination and mic_contamination folder each with a blast_check_07a.sh that has the commands that convert unmapped reads in the bam to fastqs, assembles them with spades, and blasts them
