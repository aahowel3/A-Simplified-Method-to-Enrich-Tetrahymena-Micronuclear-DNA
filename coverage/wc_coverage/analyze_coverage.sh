#USAGE: command line input should look like $bash analyze coverage.sh *SB210*

#use input argument @ for unspecified number of arguments
for arg in "$@"
do
        file=$(basename "$arg" _SB210_tomic_coverage.txt)
	Rscript analyze_coverage.R "${file}_IESs_inmic.tsv" "${file}_SB210_tomic_coverage.txt"
done 
