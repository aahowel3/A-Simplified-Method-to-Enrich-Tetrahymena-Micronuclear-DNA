#USAGE: command line input should look like $bash analyze coverage.sh *Mac*

#use input argument @ for unspecified number of arguments
for arg in "$@"
do
        file=$(basename "$arg" _Mac_tomic_coverage.txt)
#	chromo=$(echo $file| grep -oP '.*?(?=\.)')
#	chromo_number=$(echo "${chromo: -1}")
	Rscript ./coverage_05/analyze_coverage_allchromo_05d.R ./coverage_05/"${file}"_IESs_inmic.tsv ./coverage_05/mac_coverage/"${file}_Mac_tomic_coverage.txt" >> wholechromo.mac.txt
done 
