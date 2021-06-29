#USAGE: command line input should look like $bash analyze coverage.sh *SB210*

#use input argument @ for unspecified number of arguments
for arg in "$@"
do
        file=$(basename "$arg" _SB210_tomic_coverage.txt)
#	echo /work/aahowel3/flowsortdata/2931489_Howell/retention_scores/"${file}_IESs_inmic.csv" "${file}_SB210_tomic_coverage.txt"
	Rscript /work/aahowel3/flowsortdata/2931489_Howell/retention_scores/coverage/analyze_coverage.R /work/aahowel3/flowsortdata/2931489_Howell/retention_scores/"${file}_IESs_inmic.tsv" "${file}_SB210_tomic_coverage.txt"
done 