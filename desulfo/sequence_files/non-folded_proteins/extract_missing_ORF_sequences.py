import sys

def load_targets(orfs_file):
    """Load target indices, zero-padded to 4 digits."""
    with open(orfs_file) as f:
        return {"{:04d}".format(int(line.strip())) for line in f if line.strip()}

def fasta_filter(fasta_file, targets, output_file):
    """Extract and write FASTA entries matching the target indices."""
    with open(fasta_file) as fin, open(output_file, "w") as fout:
        keep = False
        for line in fin:
            if line.startswith('>'):
                # Example: >DESULFOASV1_00010 ...
                parts = line.split()
                if parts:
                    header = parts[0]
                    # Extract the number after the last underscore (should be 5 digits)
                    idx5 = header.rsplit('_', 1)[-1][:5]
                    if len(idx5) == 5 and idx5.endswith('0'):
                        idx4 = idx5[:-1]  # Remove trailing zero, e.g. 00010 -> 0001
                    else:
                        idx4 = idx5  # fallback: use as is
                    if idx4 in targets:
                        keep = True
                        fout.write(line)
                    else:
                        keep = False
                else:
                    keep = False
            else:
                if keep:
                    fout.write(line)

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python extract_matching_orfs.py protein.faa missing_ORFs.txt output.faa")
        sys.exit(1)
    fasta_file = sys.argv[1]
    orfs_file = sys.argv[2]
    output_file = sys.argv[3]
    targets = load_targets(orfs_file)
    fasta_filter(fasta_file, targets, output_file)
    print(f"Done. Wrote matching entries to {output_file}")
