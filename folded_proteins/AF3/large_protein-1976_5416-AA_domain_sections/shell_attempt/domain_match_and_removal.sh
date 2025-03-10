#!/bin/bash 

domain_file="Loki_titin-like_domain_1.pdb"
target_file="Loki_ORF1976_AF3_titin-like_one-chain.pdb"
domain_name=${domain_file%%.pdb}

# Set .tsv file for hold matches
echo "Domain	Iteration	Eval	Start Idx	End Idx" > ${domain_name}_match_locations.tsv

eval_exp="-20" 

cp $target_file ${target_file}_-1

ITER=0
while [ $eval_exp -lt "-3" ]
do
	prev_ITER=$((ITER-1))
	cp ${target_file}_${prev_ITER}  ${target_file}_${ITER}
	# search domain against full titin-like structure, get the start and end index # from the target (titin-like full). Grab evalue for filtering
	foldseek easy-search --format-output query,target,evalue,tstart,tend,tlen $domain_file ${target_file}_${ITER} ${domain_name}.m8 tmp

	# target start is the 4th column (pulled out via cut)
	eval=$(cut -f 3 -d$'\t' ${domain_name}.m8)
	eval_exp=${eval#*E}  # drop everything up to E to get the exponent
	tstart=$(cut -f 4 -d$'\t' ${domain_name}.m8)
	tend=$(cut -f 5 -d$'\t' ${domain_name}.m8)
	tlen=$(cut -f 6 -d$'\t' ${domain_name}.m8) #may as well take tlen directly 


	echo "$domain_name	$iteration	$eval	$tstart	$tend" >> ${domain_name}_match_locations.tsv
	
	# sed is very hard to read but the easiest way to change just one line
	# from here: https://stackoverflow.com/questions/54928982/bash-remove-specific-character-range-from-specific-line
	# says, roughly "go to line 2, remember all residues up the start, ignore the match lenght, and remember the rest. Ovewrite" 
	# the shell will expand the variable for sed, as long as double quotes are used 
	sed -E -i '2 s/^(.{'"$tstart"'}).{'"$tlen"'}(.*)/\1\2/' ${target_file}_${ITER}

	echo "New e-value exponent is"
	echo $eval_exp
	((ITER++))
done
