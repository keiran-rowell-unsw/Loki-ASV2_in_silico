#!/bin/bash
protein_dir="/opt/gitrepo/burns-lab-biomolecule-structures/archea-stephanie-nobs/folded_proteins"
dbs=(/mnt/datapool_biodatabases/PDB100/PDB /mnt/datapool_biodatabases/afdb_swissprot/afdb_swissprot)
for protein_file in ${protein_dir}/*/*.pdb
   do
   protein=$(basename "$protein_file" .pdb)
   ITER=0
   for db in ${dbs[@]};
   do
      echo $db   
      foldseek easy-search $protein_file $db aln_${protein}_${ITER}.m8 tmp --format-output query,target,theader,evalue,prob,bits,qstart,qend,qlen,tstart,tend,tlen,alnlen,qcov,tcov
      cat aln_${protein}_${ITER}.m8 >> aln_${protein}_tot.m8   
      echo $ITER
      ((ITER++))
   done
done
