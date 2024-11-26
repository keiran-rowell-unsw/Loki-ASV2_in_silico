# -KR nevermind the foldseek API returns "we don't have enough resources" as of 2024-11-19. 
#  API disable has been ongoing since Feb 2024 https://github.com/steineggerlab/foldseek/issues/242

for file in /mnt/data/archeaota_closed_genoproteomes/archea-loki-ASV2/folded_proteins/complete_proteome_top_pdb/*.pdb
   do 
      curl -X POST https://search.mmseqs.com/api/ticket -F q=$file -F 'mode=3diaa' -F 'database[]=pdb100' -F 'database[]=afdb-swissprot' -F 'database[]=afdb50' -F 'database[]=afdb-proteome' -F 'database[]=mgnify_esm30' -F 'database[]=gmgcl_id' -F 'database[]=bfmd' -F 'database[]=cath50' -F 'database[]=bfvd'
  done
