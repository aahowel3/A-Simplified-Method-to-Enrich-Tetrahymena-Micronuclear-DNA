library(ggplot2)
datamic1=read.csv("chr1IRSscores_micsample.txt",sep="\t",header=FALSE)
datamic2=read.csv("chr2IRSscores_micsample.txt",sep="\t",header=FALSE)
datamic3=read.csv("chr3IRSscores_micsample.txt",sep="\t",header=FALSE)
datamic4=read.csv("chr4IRSscores_micsample.txt",sep="\t",header=FALSE)
datamic5=read.csv("chr5IRSscores_micsample.txt",sep="\t",header=FALSE)
datamic=rbind(datamic1,datamic2,datamic3,datamic4,datamic5)

names(datamic)=c("IES_ID","IESplus","IESminus")

datamic$IRS=(datamic$IESplus)/(datamic$IESplus + datamic$IESminus) 
datamic[is.na(datamic)] = 0 

length(which(datamic$IRS == "0"))

mean(datamic$IRS)

barplot(table(datamic$IRS), main="IES Retention Scores Micronuclear FACS Sample (Chromosomes 1-5)", xlab="IRS", ylab="Frequency")

###########################################################################################
datamac1=read.csv("chr1IRSscores_macsample.txt",sep="\t",header=FALSE)
datamac2=read.csv("chr2IRSscores_macsample.txt",sep="\t",header=FALSE)
datamac3=read.csv("chr3IRSscores_macsample.txt",sep="\t",header=FALSE)
datamac4=read.csv("chr4IRSscores_macsample.txt",sep="\t",header=FALSE)
datamac5=read.csv("chr5IRSscores_macsample.txt",sep="\t",header=FALSE)
datamac=rbind(datamac1,datamac2,datamac3,datamac4,datamac5)

names(datamac)=c("IES_ID","IESplus","IESminus")

datamac$IRS=(datamac$IESplus)/(datamac$IESplus + datamac$IESminus) 
datamac[is.na(datamac)] = 0 

mean(datamac$IRS)

barplot(table(datamac$IRS), main="IES Retention Scores Macronuclear FACS Sample (Chromosomes 1-5)", xlab="IRS", ylab="Frequency")

#################################################
datamic$FACS_Sample="MIC"
datamac$FACS_Sample="MAC"
longform = rbind(datamic,datamac)

ggplot(longform, aes(IRS, fill=FACS_Sample)) + geom_histogram(position="dodge") + ggtitle("IES Retention Scores (Chromosomes 1-5)") + theme(plot.title = element_text(hjust = 0.5))


#KS test to compare similarity of histograms
require(graphics)
require(dgof)

x=datamic$IRS

y=datamac$IRS

#example provided 
x <- rnorm(50)
y <- runif(30)
# Do x and y come from the same distribution?
ks.test(x, y)
