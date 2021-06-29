#create a 1million read subset of a whole cell mic+mac sample (ancestor, not GE'd) to compare to our purified mic/mac sample
#R1 = ~500,000 R2 = ~500,000 (look at fastqc report of Mac and Mic TRIMMED in ./quality_control to see how many reads you need to sample)

for filename in SB210E*_1_*R1*.fastq
do
cat $filename >> SB210E_R1.fastq
done 

for filename in SB210E*_1_*R2*.fastq
do
        cat $filename >> SB210E_R2.fastq
done

seqtk sample -s100 SB210E_R1.fastq 503983 > SB210E_subset_R1.fq 
seqtk sample -s100 SB210E_R2.fastq 503983 > SB210E_subset_R2.fq




