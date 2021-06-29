#from the chrX_IESs_inmic.csv series - extract columns first (IES name)
#last and second to last (coordinates of IES in Mic)

#usage bash make_bedfile.sh ..//retention_scores/chr*inmic.tsv


for arg in $@
do	
	file=$(basename "$arg" .tsv)
#create new col of unique identifier
	awk 'BEGIN {FS="\t"; OFS="\t"} {print $8, $11, $12, $4"_"$8"_"$11}' ../retention_scores/"${file}.tsv"  > "${file}.bed"
	sed -i '1d' "${file}.bed"
done


