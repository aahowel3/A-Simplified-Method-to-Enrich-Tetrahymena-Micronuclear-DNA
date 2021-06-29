#creates 5 fasta files of all IESs in each chromosome 
#usage = bash make_IESfasta.sh chr*.bed

reference=/path/to/reference 

for arg in $@
do
	file=$(basename "$arg" .bed)
	bedtools getfasta -fi "$reference" -bed "${file}.bed" -name -fo "${file}.fasta"
done

cat chr*.fasta > IES_references.fasta
