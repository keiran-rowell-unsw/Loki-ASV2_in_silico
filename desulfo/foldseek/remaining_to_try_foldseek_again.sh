#!/bin/bash

# Want: 
#   	TSV with single hit for each ORF/protein, taken from lowest bitscore from either a) PDB100 or b) Swiss-Prot (because best annotations)
#       Formatting: --format-mode 4

foldseek_again_prots=(DESULFOASV1_0326_hypothetical_protein.pdb DESULFOASV1_0379_glutamate_synthase-related_protein.pdb DESULFOASV1_0463_PAS_domain_S-box_protein.pdb DESULFOASV1_0669-Fe-S-binding_protein.pdb DESULFOASV1_0902_hypothetical_protein.pdb DESULFOASV1_1455_hypothetical_protein.pdb DESULFOASV1_2439_hypothetical_protein.pdb DESULFOASV1_2632_hypothetical_protein.pdb DESULFOASV1_2812_hypothetical_protein.pdb DESULFOASV1_2821_hypothetical_protein.pdb DESULFOASV1_2857_hypothetical_protein.pdb DESULFOASV1_2871_AIR_synthase-related_protein.pdb DESULFOASV1_3145_PEP-pyruvate-binding_domain-containing_protein.pdb DESULFOASV1_3445_NAD-glutamate_dehydrogenase.pdb DESULFOASV1_3642_hypothetical_protein.pdb DESULFOASV1_3719_DNA-directed_RNA_polymerase_subunit_beta-.pdb)

proteins_dir="/opt/gitrepo/Loki-ASV2_in_silico/desulfo/folded_proteins/complete_proteome_top_pdb"

swissprot_db=/mnt/datapool_biodatabases/afdb_swissprot/afdb_swissprot
pdb100_db=/mnt/datapool_biodatabases/PDB100/PDB

for prot in ${foldseek_again_prots[@]}
do
   trgt_prot="${proteins_dir}/${prot}"
   ORGANISM_ID=$(basename $trgt_prot | cut -d '_' -f 1)
   ORF_ID=$(basename $trgt_prot | cut -d '_' -f 2)
   echo $ORF_ID
   foldseek easy-search $trgt_prot $swissprot_db foldseek_${ORGANISM_ID}_${ORF_ID}_afdb-swissprot.tsv tmp --format-mode 4 --format-output query,target,qheader,theader,fident,alnlen,mismatch,qstart,qend,tstart,tend,evalue,bits 
   foldseek easy-search $trgt_prot $pdb100_db foldseek_${ORGANISM_ID}_${ORF_ID}_pdb100.tsv tmp --format-mode 4 --format-output query,target,qheader,theader,fident,alnlen,mismatch,qstart,qend,tstart,tend,evalue,bits 
done


