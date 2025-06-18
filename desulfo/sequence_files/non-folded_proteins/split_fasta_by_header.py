import sys

if len(sys.argv) != 2:
    print("Usage: python split_fasta_by_header.py missing_ORFs.faa")
    sys.exit(1)

with open(sys.argv[1]) as infile:
    out = None
    for line in infile:
        if line.startswith(">"):
            if out:
                out.close()
            filename = line[1:].split()[0] + ".faa"
            out = open(filename, "w")
            out.write(line)
        else:
            if out:
                out.write(line)
    if out:
        out.close()
