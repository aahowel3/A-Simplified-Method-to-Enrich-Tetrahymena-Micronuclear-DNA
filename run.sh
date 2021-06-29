#Data 01
#run trimmomatic and fastqc on raw FACS reads 
bash ./data_01/flowsort_curation_01a.sh ./data_01/*R1_001.fastq.gz

#Whole cell data 02
#subset whole cell reads from (Long et al., 2016) (BioProject PRJNA285268) 
bash ./wholecell_data_02/subset_02a.sh /path/to/downloaded/wholecell_data

#Fisher's exact test 03
#align MIC and MAC trimmed FACS reads to combined reference 
bash ./fishers_exact_03/fishers_rerun_2_03a.sh ./data_01/*R1_001.trim.fastq.gz
#align whole cell subsets to combined reference 
bash ./fishers_exact_03/wholecell_subset/flowsort_curation_wc_2_03b.sh ./data_01/*R1_001.trim.fastq.gz
#remove unmapped reads from resulting bam files
samtools view -b -h -F 4 file.bam > mapped.bam
#count reads aligned to the MIC or MAC reference for each resulting bam file
samtools view FACSsample_toconcatref_mapped.bam | grep -v "XA:" | grep -v "SA:" | awk '$3 ~ /scf/' | wc -l 
samtools view FACSsample_toconcatref_mapped.bam | grep -v "XA:" | grep -v "SA:" | awk '$3 ~ /chr/' | wc -l 
#run a fisher's exact test on the resulting counts
R ./fishers_exact_03/fishers_rerun_ftests_03c.R 

#Simulations 04 
#remove mitochondrial sequence to generate mac simulated reads 
awk '{ if ((NR>1)&&($0~/^>/)) { printf("\n%s", $0); } else if (NR==1) { printf("%s", $0); } else { printf("\t%s", $0); } }' mac.genome.fasta | grep -v -Ff remove.txt - | tr "\t" "\n" > mac.genome_nomito.fasta
#generate simulated mic, mac, and whole cell data at a 2:45 mic to mac ratio
bash ./simulations_04/wc_simulations_04a.sh
#align simulated whole cell reads to the combined reference genome 
bash ./simulations/flowsortcuration_2_wc_04b.sh
#align simulated MIC and MAC reads to the combined reference genome 
bash ./simulations/flowsortcuration_2_mic_mac_04c.sh
#remove unmapped reads from resultsing bam files 
samtools view -b -h -F 4 file.bam > mapped.bam
#generate simulated mic, mac, and whole cell data at a 1:1 mic to mac ratio
bash ./simulations_1x/wc_simulations_1x_04d.sh
#align simulated whole cell reads to the combined reference genome 
bash ./simulations_1x/flowsortcuration_2_wc_04e.sh

#Coverage MDS and IES 05 
#IES_coordinates.csv
R ./coverage/merge_contigs.R
