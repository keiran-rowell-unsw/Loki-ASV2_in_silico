ub=4545 # Replace this with the largest existing file's number.
seq "$ub" | while read -r i; do
    [[ -f "LOKIASV2_${i}_*.pdb" ]] || echo "$iis missing"
:q!
ls
done
