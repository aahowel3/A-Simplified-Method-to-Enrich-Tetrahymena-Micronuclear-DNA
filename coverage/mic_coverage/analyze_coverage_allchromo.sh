#USAGE: command line input should look like $bash analyze coverage.sh *Mac*

#use input argument @ for unspecified number of arguments
for arg in "$@"
do
        file=$(basename "$arg" _Mic_tomic_coverage.txt)
#	echo /work/aahowel3/flowsortdata/2931489_Howell/retention_scores/"${file}_IESs_inmic.csv" "${file}_Mic_tomic_coverage.txt"
	Rscript /work/aahowel3/flowsortdata/2931489_Howell/retention_scores/coverage/analyze_coverage_allchromo.R /work/aahowel3/flowsortdata/2931489_Howell/retention_scores/"${file}_IESs_inmic.tsv" "${file}_Mic_tomic_coverage.txt" >> wholechromo.mic.txt
done 
