#USAGE: command line input should look like $bash flowsort_curation_01a.sh *_1.fastq
#trimmomatic adapter file in same directory TruSeq-3-PE-2.fa


#use input argument @ for unspecified number of arguments
for arg in "$@"
do
#strips out SRR part of filename, can then use the basename to specify the R1 and R2 files with the same basename in the trimmomatic command
        file=$(basename "$arg" _1.fastq)
#runs trimmomatic on each read pair - outupts are 2 trimed files and 2 untrimmed files where the discarded reads go
        trimmomatic PE ./data_01/"${file}_1.fastq" ./data_01/"${file}_2.fastq" ./data_01/"${file}_1.trim.fastq" ./data_01/"${file}_1.untrim.fastq" ./data_01/"${file}_2.trim.fastq" ./data_01/"${file}_2.untrim.fastq" SLIDINGWINDOW:4:20 MINLEN:35 ILLUMINACLIP:data_01/TruSeq3-PE-2.fa:2:30:10
	fastqc ./data_01/"${file}_1.trim.fastq" ./data_01/"${file}_2.trim.fastq"
done

 

