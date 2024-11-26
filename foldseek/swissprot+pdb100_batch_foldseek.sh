#!/bin/bash

# Want: 
#   	TSV with single hit for each ORF/protein, taken from lowest bitscore from either a) PDB100 or b) Swiss-Prot (because best annotations)
#       Formatting: --format-mode 4

proteins_dir="/mnt/data/archeaota_closed_genoproteomes/archea-loki-ASV2/folded_proteins/complete_proteome_top_pdb"

swissprot_db=/mnt/datapool_biodatabases/afdb_swissprot/afdb_swissprot
pdb100_db=/mnt/datapool_biodatabases/PDB100/PDB
#out_dir=/opt/gitrepo/burns-lab-biomolecule-structures/archea-stephanie-nobs/foldseek_alignments
#Brace expansion separate ranges are awesome!
for prot in $proteins_dir/*.pdb
do
   ORGANISM_ID=$(basename $prot | cut -d '_' -f 1)
   ORF_ID=$(basename $prot | cut -d '_' -f 2)
   echo $ORF_ID
   foldseek easy-search $prot $swissprot_db foldseek_${ORGANISM_ID}_${ORF_ID}_afdb-swissprot.tsv tmp --format-mode 4 --format-output query,target,qheader,theader,fident,alnlen,mismatch,qstart,qend,tstart,tend,evalue,bits 
   foldseek easy-search $prot $pdb100_db foldseek_${ORGANISM_ID}_${ORF_ID}_pdb100.tsv tmp --format-mode 4 --format-output query,target,qheader,theader,fident,alnlen,mismatch,qstart,qend,tstart,tend,evalue,bits 
done


