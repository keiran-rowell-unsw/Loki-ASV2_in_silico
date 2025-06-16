#!/bin/bash

#Searching the Nelly proteome that has been foldseeked using PDBs of ESPs as queries
protein_dir="/home/stefjn/ESPquery"
# easy-search points to the DB file not the containing folder
db="/opt/gitrepo/burns-lab-biomolecule-structures/archea-stephanie-nobs/nelly_foldseek_dbs/DB"
#curved brackets only needed for multiple DBs
for protein_file in ${protein_dir}/*.pdb
do
        protein=$(basename "$protein_file" .pdb)
        foldseek easy-search $protein_file $db result_${protein}.html tmp --format-mode 3
done
