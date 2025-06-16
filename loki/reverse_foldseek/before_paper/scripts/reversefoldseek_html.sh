#!/bin/bash

#Searching the Nelly proteome that has been foldseeked using PDBs of ESPs as queries
protein_dir="/home/stefjn/paper"
# easy-search points to the DB file not the containing folder
db="/mnt/data/archeaota_closed_genoproteomes/archea-loki-ASV2/reverse_foldseek/Nelly_DB/Nelly_closed_proteome_foldseek_DB"
#curved brackets only needed for multiple DBs
for protein_file in ${protein_dir}/*.pdb
do
	protein=$(basename "$protein_file" .pdb)
	foldseek easy-search $protein_file $db result_${protein}.html tmp --format-mode 3
done

mv *.html /home/stefjn/paper
mv *.pdb /home/stefjn/paper


