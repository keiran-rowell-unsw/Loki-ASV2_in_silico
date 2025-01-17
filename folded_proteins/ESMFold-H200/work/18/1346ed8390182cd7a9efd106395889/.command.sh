#!/bin/bash -euo pipefail
esm-fold         -i loki-ASV2_dfast_all_protein_ORFs.fasta         -o $PWD         -m $PWD         --num-recycles 4         --cpu-only

awk '{print $2"\t"$3"\t"$4"\t"$6"\t"$11}' "loki-ASV2_dfast_all_protein_ORFs"*.pdb | grep -v 'N/A' | uniq > plddt.tsv
echo -e Atom_serial_number"\t"Atom_name"\t"Residue_name"\t"Residue_sequence_number"\t"pLDDT > header.tsv
cat header.tsv plddt.tsv > "loki-ASV2_dfast_all_protein_ORFs"_plddt_mqc.tsv

cat <<-END_VERSIONS > versions.yml
"NFCORE_PROTEINFOLD:ESMFOLD:RUN_ESMFOLD":
    esm-fold: 1.0.3
END_VERSIONS
