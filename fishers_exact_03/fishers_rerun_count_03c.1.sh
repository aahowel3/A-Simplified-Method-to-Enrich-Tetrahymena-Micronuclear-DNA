#count reads mapped uniquely to each reference genome 
MIC2MIC=$(samtools view bam2/SRR14745910_tomicmac_sorted_rmdup_mapped.bam | grep -v "XA:" | grep -v "SA:" | awk '$3 == "chr1" || $3 == "chr2" || $3 == "chr3" || $3 == "chr4" || $3 == "chr5"' | wc -l)
MIC2MAC=$(samtools view bam2/SRR14745910_tomicmac_sorted_rmdup_mapped.bam | grep -v "XA:" | grep -v "SA:" | awk '$3 ~ /chr_/' | wc -l)
total=$(($MIC2MIC + $MIC2MAC))
echo "mic2mic"
expr $MIC2MIC/$total
echo "mic2mac" 
expr $MIC2MAC/$total 

MAC2MAC=$(samtools view bam2/SRR14745909_tomicmac_sorted_rmdup_mapped.bam | grep -v "XA:" | grep -v "SA:" | awk '$3 ~ /chr_/' | wc -l)
MAC2MIC=$(samtools view bam2/SRR14745909_tomicmac_sorted_rmdup_mapped.bam | grep -v "XA:" | grep -v "SA:" | awk '$3 == "chr1" || $3 == "chr2" || $3 == "chr3" || $3 == "chr4" || $3 == "chr5"' | wc -l)
total=$(($MAC2MAC + $MAC2MIC))
echo "mac2mac"
expr $MAC2MAC/$total
echo "mac2mic"
expr $MAC2MIC/$total

WC2MAC=$(samtools view wholecell_subset/bam2/SB210E_subset_tomicmac_sorted_rmdup_mapped.bam | grep -v "XA:" | grep -v "SA:" | awk '$3 ~ /chr_/' | wc -l)
WC2MIC=$(samtools view wholecell_subset/bam2/SB210E_subset_tomicmac_sorted_rmdup_mapped.bam | grep -v "XA:" | grep -v "SA:" | awk '$3 == "chr1" || $3 == "chr2" || $3 == "chr3" || $3 == "chr4" || $3 == "chr5"' | wc -l)
total=$(($WC2MAC + $WC2MIC))
echo "wc2mac"
expr $WC2MAC/$total
echo "wc2mic"
expr $WC2MIC/$total

SIMULATEDMIC2MIC=$(samtools view ../simulations_04/bam_mic/mic_simulated_tomicmac_sorted_rmdup_mapped.bam | grep -v "XA:" | grep -v "SA:" | awk '$3 == "chr1" || $3 == "chr2" || $3 == "chr3" || $3 == "chr4" || $3 == "chr5"' | wc -l)
SIMULATEDMAC2MAC=$(samtools view ../simulations_04/bam_mic/mic_simulated_tomicmac_sorted_rmdup_mapped.bam | grep -v "XA:" | grep -v "SA:" | awk '$3 ~ /chr_/' | wc -l)
total=$(($SIMULATEDMIC2MIC + $SIMULATEDMAC2MAC))
echo "simmic2mic"
expr $SIMULATEDMIC2MIC/$total
echo "simmac2mac"
expr $SIMULATEDMAC2MAC/$total

SIMULATEDMAC2MIC=$(samtools view ../simulations_04/bam_mac/mac_simulated_tomicmac_sorted_rmdup_mapped.bam | grep -v "XA:" | grep -v "SA:" | awk '$3 == "chr1" || $3 == "chr2" || $3 == "chr3" || $3 == "chr4" || $3 == "chr5"' | wc -l)
SIMULATEDMIC2MAC=$(samtools view ../simulations_04/bam_mac/mac_simulated_tomicmac_sorted_rmdup_mapped.bam | grep -v "XA:" | grep -v "SA:" | awk '$3 ~ /chr_/' | wc -l)
total=$(($SIMULATEDMAC2MIC + $SIMULATEDMIC2MAC))
echo "simmac2mic"
expr $SIMULATEDMAC2MIC/$total
echo "simmic2mac"
expr $SIMULATEDMIC2MAC/$total

WCSIM2MIC464=$(samtools view ../simulations_04/bam/wc_simulated_tomicmac_sorted_rmdup_mapped.bam | grep -v "XA:" | grep -v "SA:" | awk '$3 == "chr1" || $3 == "chr2" || $3 == "chr3" || $3 == "chr4" || $3 == "chr5"' | wc -l)
WCSIM2MAC464=$(samtools view ../simulations_04/bam/wc_simulated_tomicmac_sorted_rmdup_mapped.bam | grep -v "XA:" | grep -v "SA:" | awk '$3 ~ /chr_/' | wc -l)
total=$(($WCSIM2MIC464 + $WCSIM2MAC464))
echo "wcsim2mic"
expr $WCSIM2MIC464/$total
echo "wcsim2mac"
expr $WCSIM2MAC464/$total

WCSIM2MIC11=$(samtools view ../simulations_04/simulations_1x/bam/wc_simulated_tomicmac_sorted_rmdup_mapped.bam | grep -v "XA:" | grep -v "SA:" | awk '$3 == "chr1" || $3 == "chr2" || $3 == "chr3" || $3 == "chr4" || $3 == "chr5"' | wc -l)
WCSIM2MAC11=$(samtools view ../simulations_04/simulations_1x/bam/wc_simulated_tomicmac_sorted_rmdup_mapped.bam | grep -v "XA:" | grep -v "SA:" | awk '$3 ~ /chr_/' | wc -l)
total=$(($WCSIM2MIC11 + $WCSIM2MAC11))
echo "wcsim2mic11"
expr $WCSIM2MIC11/$total
echo "wcsim2mac11"
expr $WCSIM2MAC11/$total
