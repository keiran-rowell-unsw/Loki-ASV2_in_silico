awk '
{
    if (match($0, /(LOKIASV2_[0-9]+)/, id) && match($0, /pTM ([0-9]+\.[0-9]+)/, pTM)) {
        print "Identifier: " id[1] ", pTM: " pTM[1];
    }
}
' esmfold_loki-ASV2_all_ORFs.log 
