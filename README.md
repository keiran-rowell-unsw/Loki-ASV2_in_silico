# Loki-ASV2_in_silico
In Silico protein structure data for Loki-ASV2 paper - raw files, data tables, rendered images, processing code

Supporting Information files for *An Asgard archaeon from a modern analog of ancient microbial mats* [working title].

## Links
**DOI**: TBD \
**Zenodo Link**: TBD \
**ModelArchive entry**: https://modelarchive.org/doi/10.5452/ma-6k8yb 

## Folder structure
```
--- folded_proteins: all predicted protein structres divided by method  
|   |
|   - complete_proteome_top_pdb: the rank_0 pdb file from ESM/AlphaFold as described in the manuscript methods
|   - AF2.3: AlphaFold2.3
|   - AF3: AlphaFold3 including some analysis of the Titin-like protein structure (#1976)
|   - ESMFold: Structures that fit inside 40GB of VRAM (< 880 residues) 
|   - Boltz+MMSeqs2-GPU: Complete proteome structures re-predicted with open-source AF3 reimplementation. Not discussed in manuscript 
|   - scripting_too_big_for_ESMFold: Scripts to handle protein identities when ESMFold jobs failed etc 
|
--- foldseek: complete foldseek searches for each protein against *all* possible foldseek databases
|
--- protein_mugshots: PyMol render images of plDDT confidence scores of each protein. Includes scripts used 
|
--- reverse_foldseek: Using foldseek to search for Eukaroytic Signature Proteins in the Loki-ASV2 *In Silico* proteome. Signature proteins compiled by Stephanie J. Nobs with supervisory input from Kate Michie.
```

## Exclusions 
The follow file types have been excluded from upload due to size considerations:
- .pkl
- .a3m
- .npz
- .pt
- .sif

## BibTeX entry
```
@article{Loki-ASV2,
  title={An Asgard archaeon from a modern analogue of ancient microbial mats},
  author={Nobs, Stephanie AND Johnson, Matthew D. AND Williams, Timothy J. AND Meltzer, Julia AND Vazquez-Campos, Xabier AND MacLeod, Fraser I. AND Rowell, Keiran AND Miranda, Pitt AND Paul, Bindusmita AND Shepherd, Doulin C. AND Michie, Katharine A. AND Duggin, Iain G. AND Ghosal, Debnath AND Burns, Brendan P.},
  journal={Unsubmitted},
  year={TBD}
}
```
