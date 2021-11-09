#creates a chain file for each chromosome 
library(dplyr)

df1=read.csv("mic.mac.sorted.chain",sep="",header=FALSE)
#final trailing column on the second line is part of the "alignment data lines"
#column = size of ungapped alignment 

#formated chain on back end so no need to do this here
#extract out comeplete rows
#df1 = data[seq(1, nrow(data), 2), ]
#extract out lagging last column
#df2 = data[seq(2, nrow(data), 2), ]
#glue together
#df1 <- cbind(df1, V14 = df2$V1)

names(df1)=c("chain","chainscore","refname","refsize","strand","refstart","refend","queryname",
             "querysize","qstrand","querystart","queryend","chainID")

#order and subset
#subset my chromosome
df2=df1[with(df1,order(queryname,querystart)),]
chain_bychr=split(df2,with(df2,interaction(queryname)),drop=TRUE)

#shift columns of chain file so you can check if IES range x-y falls between gap a-b between end of one mac scaffold and beginning of another
res <- lapply(chain_bychr, function(x){
  x$queryshift = append(x$querystart[-1],x$querysize[1])
  
  x$refshift = append(x$refstart[-1],x$refend[1])
  
  x$refnameshift = append(as.character(x$refname[-1]),as.character(last(x$refname)))
  
  
  col_order = c("chain","chainscore","refname","refsize","strand","refstart","refend","refshift","refnameshift","queryname",
                "querysize","qstrand","querystart","queryend","queryshift","chainID")
  x = x[,col_order]
  x = x[with(x,order(queryend)),]
  
}) 

#Write to 5 different files per chromosome
write.table(res$chr1,file="chr1_chain.tsv",row.names = FALSE,sep="\t", quote=FALSE)
write.table(res$chr2,file="chr2_chain.tsv",row.names = FALSE,sep="\t", quote=FALSE)
write.table(res$chr3,file="chr3_chain.tsv",row.names = FALSE,sep="\t", quote=FALSE)
write.table(res$chr4,file="chr4_chain.tsv",row.names = FALSE,sep="\t", quote=FALSE)
write.table(res$chr5,file="chr5_chain.tsv",row.names = FALSE,sep="\t", quote=FALSE)
