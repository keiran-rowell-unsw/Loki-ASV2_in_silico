awk -F'\t' 'NR==FNR; IFS='\t'; {indices[$1]; next} $1 in indices {print $1, $6}' hypothetical_proteins.tsv interproscan_filtered_good_annotations_Pfam.tsv > annotations_from_indices.txt 
#awk -F'\t' 'NR==FNR; IFS='\t'; {indices[$1]; next} $1 in indices {print $1, $6}' indices.txt annotations.txt > output.txt
