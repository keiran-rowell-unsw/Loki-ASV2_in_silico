#!/bin/bash

# Want: 
# 	1. HTML5 file for each protein, for all databases
#   	2. TSV with single hit for each ORF/protein, taken from lowest bitscore from either a) PDB100 or b) Swiss-Prot (because best annotations)
#       Formatting: 1) is --format-mode 3  3) is --format-mode 4

# Issue 75 shows searching multiple DBs at once isn't supported. 
# So I think I should do #1) uniprot for the 1-top-hit, and each protein HTML and PDB overlay reports  #2) concatenated .tsv files for each protein and the 1-top-hit

proteins_dir="/mnt/data/archeaota_closed_genoproteomes/archea-loki-ASV2/folded_proteins/complete_proteome_top_pdb"

## For making the foldseek_all_db need to run each of the dbs below as argument to 'foldseek createdb [db_locations] [foldseek_all_db_dir]/fs_all_DB 
dbs=(/mnt/datapool_biodatabases/afdb_uniprot50/UniProt50 /mnt/datapool_biodatabases/afdb_swissprot/afdb_swissprot  /mnt/datapool_biodatabases/afdb_proteome/Proteome /mnt/datapool_biodatabases/CATH50/CATH50 /mnt/datapool_biodatabases/mgnify/mgy_clusters_2022_05.fa /mnt/datapool_biodatabases/PDB100/PDB /mnt/datapool_biodatabases/ESM30/highquality_clust30 /mnt/datapool_biodatabases/BFMD/bfmd /mnt/datapool_biodatabases/BFVD/bfvd)

#for prot in $proteins_dir/*.pdb
for prot in $proteins_dir/*{4010..4545}*.pdb # had to kill foldseek partway to give alphafold a chance 
do
   prot_name=$(basename "$prot")
   echo $prot_name
   IFS='_' read -r part1 part2 rest <<< "$prot_name"  # LLM solution, not a huge fan but ${var%%_*} throws away too much
   prot_name="${part1}_${part2}" 
   echo $prot_name
   for db in ${dbs[@]};
   do 
	db_type=$(basename "$db")
	if [ "$db_type" == mgy_clusters_2022_05.fa ]; then
		db_type="mgnify"
	fi
        echo $db_type	
	foldseek easy-search $prot $db aln_${prot_name}_${db_type}.tsv tmp --format-output query,target,theader,evalue,prob,bits,qstart,qend,qlen,tstart,tend,tlen,alnlen,qcov,tcov
        cat aln_${prot_name}_${db_type}.tsv >> aln_${prot_name}_all_foldseek_dbs.tsv 
   done
done


