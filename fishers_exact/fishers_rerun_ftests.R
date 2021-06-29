#matrix format for fishers
#datax=matrix(c(mic2mic,mic2mac,wc2mic,wc2mac), ncol=2,byrow=TRUE)
datax=matrix(c(32864,7298,27641,15795), ncol=2,byrow=TRUE)

#datax=matrix(c(mac2mac,mac2mic,wc2mac,wc2mic), ncol=2,byrow=TRUE)
datax=matrix(c(25005,6158,15795,27641), ncol=2,byrow=TRUE)

#datax=matrix(c(mac2mac,mac2mic,mic2mac,mic2mic), ncol=2,byrow=TRUE)
datax=matrix(c(25005,6158,7298,32864), ncol=2,byrow=TRUE)

#datax=matrix(c(wc2mic_sim,wc2mac_sim,wc2mic,wc2mac), ncol=2,byrow=TRUE)
datax=matrix(c(294578,735232,15795,27641), ncol=2,byrow=TRUE)

#run for each once you design the matrix for which 2 samples you want to test 
data=as.data.frame(datax)
fisher.test(data, alternative="greater")
