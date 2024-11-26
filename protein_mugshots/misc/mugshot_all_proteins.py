from glob import glob
from pymol import cmd

for file in glob("/home/keiran/code/UNSW/archeaota_closed_genoproteomes/archea-loki-ASV2/folded_proteins/complete_proteome_top_pdb/*.pdb"):
  cmd.run(takeMugshot, file)
  cmd.delete(file)
