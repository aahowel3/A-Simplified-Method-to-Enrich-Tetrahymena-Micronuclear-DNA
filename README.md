# A-Simplified-Method-to-Enrich-Tetrahymena-Micronuclear-DNA

# Raw Data
flowsort_curation.sh in /data runs trimmomatic on Mic and Mac pairs of fastq files and then fastqc on trimmmed files <br />
used TrueSeqv3 adapter trimming for illumina universal adapter

# Whole Cell Data
in /wholecell_data subset.sh creates a subset of reads from nonGE ancestors (Long et al., 2016) (BioProject PRJNA285268) with the same number of reads as the original Mic and Mac flowsorted sequencing samples

# Fisher's exact tests  
fishers_rerun_2.sh in /fishers_exact runs the MIC and MAC FACS against the combined refernece plus rDNA reference into bam2 and sam2 <br />
in /fishers_exact/wholecell_subset fishers_rerun_wc_2.sh reruns WC against the combined refernece plus rDNA reference into bam2 and sam2 <br />
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
