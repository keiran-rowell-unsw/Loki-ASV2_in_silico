ls *.tsv | cut -d '_' -f 3 | sort -n | uniq | awk 'NR==1{prev=$1; next} {for(i=prev+1;i<$1;i++) print i; prev=$1}'
