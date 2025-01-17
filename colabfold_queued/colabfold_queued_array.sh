#!/bin/bash

#PBS -l host=k099 
#PBS -l select=1:ngpus=1:mem=46GB
#PBS -l walltime=24:00:00
#PBS -J 0001-4544
#PBS -m ae
#PBS -j oe

cd $PBS_O_WORKDIR

cond activate /srv/scratch/sbf/localcolabfold/localcolabfold/colabfold-conda

colbafold_batch prot_${PBS_ARRAY_INDEX}
