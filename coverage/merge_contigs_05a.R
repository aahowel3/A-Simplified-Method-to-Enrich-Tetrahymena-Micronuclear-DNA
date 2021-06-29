library(tidyverse)
#read in locations of IES in the mic supercontigs but not the chromosomes itself
data1=read.csv("IES_coordinates.csv")
#read in file that links locations of mic supercontigs to mic actual chromosomes
data2=read.csv("contig_to_chromosome.csv")
#join these files in a single dataframe
data3=left_join(data1,data2,by="supercontig")

'''

#rename columns 
colnames(data3)=c("supercontig","IES_in_supercontig_start","IES_in_supercontig_end","IES_ID","IES_size",
  "start_supercontig","end_supercontig","chromosome_name","supercontig_in_chromosome_start",
  "supercontig_in_chromosome_end")

#reverse coordinates of inverted IESs (Example: 4000-1 instead of pos 1-4000) 
a=data3$IES_in_chromosome_start=data3$supercontig_in_chromosome_start + (data3$start_supercontig-data3$IES_in_supercontig_end)
b=data3$IES_in_chromosome_start=data3$supercontig_in_chromosome_start + data3$IES_in_supercontig_start 
data3=mutate(data3, IES_in_chromosome_start = ifelse(data3$start_supercontig > data3$end_supercontig, a, b))
data3$IES_in_chromosome_end=data3$IES_in_chromosome_start + data3$IES_size

'''

#split data3 by chromosome, what is an IES position in 1 chromo may not be in another 
chromo1=data3[data3$chromosome_name == "chr1",]
write.table(chromo1,file="chr1_IESs_inmic.tsv",row.names = FALSE,sep="\t", quote=FALSE)
chromo2=data3[data3$chromosome_name == "chr2",]
write.table(chromo2,file="chr2_IESs_inmic.tsv",row.names = FALSE,sep="\t", quote=FALSE)
chromo3=data3[data3$chromosome_name == "chr3",]
write.table(chromo3,file="chr3_IESs_inmic.tsv",row.names = FALSE,sep="\t", quote=FALSE)
chromo4=data3[data3$chromosome_name == "chr4",]
write.table(chromo4,file="chr4_IESs_inmic.tsv",row.names = FALSE,sep="\t", quote=FALSE)
chromo5=data3[data3$chromosome_name == "chr5",]
write.table(chromo5,file="chr5_IESs_inmic.tsv",row.names = FALSE,sep="\t", quote=FALSE)
