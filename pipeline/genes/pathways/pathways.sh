# KEGG
# fetch the KEGG files
source ./fetchKeggPathways

# load the xdbr
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/genes/pathways/kegg_xdb.json  --log-path $LOG_DIR/kegg-xdbr.log --commit


# load the pathway memberships

# REACTOME

# ditto