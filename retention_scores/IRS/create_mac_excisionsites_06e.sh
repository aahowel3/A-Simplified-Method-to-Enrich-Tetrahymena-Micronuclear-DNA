#USAGE: command line input should look like $bash create_mac_excisions.sh *chain.tsv*

#use input argument @ for unspecified number of arguments
for arg in "$@"
do
        file=$(basename "$arg" _chain.tsv)
        Rscript create_mac_excisionsites.R "${file}_chain.tsv" "${file}_IESs_inmic.tsv" 
done


