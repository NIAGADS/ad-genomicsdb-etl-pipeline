# KEGG
# fetch the KEGG files
source ./fetchKeggPathways

# load the xdbr
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/genes/pathways/kegg_xdb.json  --log-path $LOG_DIR/kegg-xdbr.log --commit


# load the pathway memberships
# --fail-on-missing-genes
runpipe-plugin --plugin KEGGLoaderPlugin --kgml-dir $DATA_DIR/KEGG --xdbref "KEGG: Kyoto Encyclopedia of Genes and Genomes|117.0" --log-path $LOG_DIR/kegg-load.log  --commit 

# REACTOME


# ditto