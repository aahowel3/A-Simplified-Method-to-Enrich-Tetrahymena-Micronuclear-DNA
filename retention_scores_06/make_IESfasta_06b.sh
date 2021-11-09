#creates 5 fasta files of all IESs in each chromosome 
#usage = bash make_IESfasta.sh chr*.bed

reference=./data_01/GCA_016584475.1.fa

for arg in $@
do
	file=$(basename "$arg" .bed)
	bedtools getfasta -fi "$reference" -bed "${file}.bed" -name -fo "${file}.fasta"
done

cat chr*.fasta > IES_references.fasta
cat IES_references.fasta ./data_01/1-upd-Genome-assembly.fasta > mac_all+IES_reference.fasta
