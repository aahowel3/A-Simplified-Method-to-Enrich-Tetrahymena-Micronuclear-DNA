#USAGE: command line input should look like $bash analyze coverage.sh *Mac*

#use input argument @ for unspecified number of arguments
for arg in "$@"
do
        file=$(basename "$arg" _SB210_tomic_coverage.txt)
	Rscript analyze_coverage_allchromo.R "${file}_IESs_inmic.tsv" "${file}_SB210_tomic_coverage.txt" >> wholechromo.wc.txt
done 
