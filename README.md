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
