#--no-long-join and -r 10 to decrease max gap size 
#IT WORKED - KEEP THIS COMMAND SET - maybe just delete the alignment lines of >10 - see what was needed for original script
minimap2 -cx asm5 --cs --no-long-join -r0 ./data_01/mic.genome.fasta ./data_01/1-upd-Genome-assembly.fasta > ./retention_scores_06/IRS/PAF_FILE.paf

#transanno requires a paf format but can convert from sam to paf with 
/work/aahowel3/transanno-v0.2.4-x86_64-unknown-linux-musl/transanno minimap2chain ./retention_scores_06/IRS/PAF_FILE.paf --output ./retention_scores_06/IRS/mic.mac.chain

grep "^chain" ./retention_scores_06/IRS/mic.mac.chain > ./retention_scores_06/IRS/mic.mac.sorted.chain
