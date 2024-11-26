# quick way to take 2nd line a the bit score 

for idx in {0001..4544}
do
   pdb100_bitscore=$(head -n 2  foldseek_LOKIASV2_${idx}_pdb100.tsv | tail -1 | cut -d$'\t' -f 13)  
   swissprot_bitscore=$(head -n 2  foldseek_LOKIASV2_${idx}_afdb-swissprot.tsv | tail -1 | cut -d$'\t' -f 13) 
   better_hit=""

   #deal with non-hits 
   if [ "$pdb100_bitscore" == "bits" ]; then echo "no pdb100 match"; better_hit="swissprot"; fi
   if [ "$swissprot_bitscore" == "bits" ]; then echo "no swissprot match"; better_hit="pdb100"; fi
   if [[ "$swissprot_bitscore" == "bits" && "$pdb100_bitscore" == "bits" ]];  then echo "no hit in either db"; better_hit="None"; fi

   # determine better hit based on bitscore
   if [ -z "${better_hit}" ]; then
      if [ "$pdb100_bitscore" -lt "$swissprot_bitscore" ]; then
         better_hit="swissprot"
      else
         better_hit="pdb100"
      fi
   fi
   if [ $better_hit == "pdb100" ]; then echo "${idx} PDB100 is the better hit"; fi
   if [ $better_hit == "swissprot" ]; then echo "${idx} Swiss-Prot is the better hit"; fi
   
   # make summary file header using 1st header  

   # put that hit to the summary file
   if [ $better_hit == "pdb100" ]; then
       head -n 2  foldseek_LOKIASV2_${idx}_pdb100.tsv | tail -1 >> foldseek_LOKIASV2_all_ORFS_top_annotated_hit.tsv
   elif [ $better_hit == "swissprot" ]; then
       head -n 2  foldseek_LOKIASV2_${idx}_afdb-swissprot.tsv | tail -1 >> foldseek_LOKIASV2_all_ORFS_top_annotated_hit.tsv
   elif [ $better_hit == "None" ]; then
       echo "LOKIASV2_ORF_${idx} not PDB100 or Swiss-Prot hit" >> foldseek_LOKIASV2_all_ORFS_top_annotated_hit.tsv
   fi       
done

# To then put the ORF annotationas from the full fasta file back in I use some awk that reads every second line, puts it to a file, then paste inserts it 
# awk '(NR - 1) % 2 == 0 { print $0 }' ../sequence_files/loki-ASV2_dfast_all_protein_ORFs.faa > ORF_fasta_annotations.txt
# paste ORF_fasta_annotations.txt foldseek_LOKIASV2_all_ORFS_top_annotated_hit.tsv > foldseek_LOKIASV2_w_ORFS_top_annotated_hit.tsv 
#
# LLM -generate awk to remove redundant target list in the description section
# awk -F'\t' 'BEGIN {OFS="\t"} {split($4, a, " "); $5 = ""; for (i=2; i<=length(a); i++) $5 = $5 a[i] " "; print $0}' input_file.tsv > output_file.tsv
