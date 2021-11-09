#USAGE: command line input should look like $bash create_mac_excisions.sh *chain.tsv*

#use input argument @ for unspecified number of arguments
for arg in "$@"
do
        file=$(basename "$arg" _chain.tsv)
        Rscript ./retention_scores_06/IRS/create_mac_excisionsites_06f.R ./retention_scores_06/IRS/"${file}_chain.tsv" ./coverage_05/"${file}_IESs_inmic.tsv" 
done


