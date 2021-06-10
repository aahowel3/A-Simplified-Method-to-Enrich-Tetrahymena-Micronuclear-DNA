#creates 5 fasta files of all IESs in each chromosome 
#can glue them together at the end


reference=/storage/reference_genomes/tetrahymena_thermophila/mic/mic.genome.fasta

#hmm save, how to use cut column as a variable in bash script
#	x=$(echo "$p" | cut -f1) 
#	bedtools getfasta -fi "$reference" -bed "$p" -name -fo "${x}.fasta"  


#usage = bash make_IESfasta.sh chr*.bed

for arg in $@
do
	file=$(basename "$arg" .bed)
	bedtools getfasta -fi "$reference" -bed "${file}.bed" -name -fo "${file}.fasta"
done



#scratched: getfasta can make a fasta from a bedfile with multiple lines, no need to make a fasta per line
#per line of bedfile create a fasta of the IES
#while read p; do
#	awk -F, '{print $1}' 
#  bedtools getfasta -fi reference -bed -fo 
#	echo "$p"
#done < $@


cat chr*.fasta > IES_references.fasta
