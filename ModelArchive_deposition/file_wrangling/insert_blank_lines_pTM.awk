awk '
{
    current = $1 + 0
    if (prev && current != prev + 1) {
        print ""
    }
    print
    prev = current
}
' ESMFold_pTMs_sorted.tsv > ESMFold_pTMs_sorted_spaced.tsv 
