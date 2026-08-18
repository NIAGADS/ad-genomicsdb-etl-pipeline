# KEGG
# fetch the KEGG files
source ./fetchKeggPathways

# load the xdbr
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/genes/pathways/kegg_xdb.json  --log-path $LOG_DIR/kegg-xdbr.log --commit


# load the pathway memberships
# --fail-on-missing-genes
runpipe-plugin --plugin KEGGLoaderPlugin --kgml-dir $DATA_DIR/KEGG --xdbref "KEGG: Kyoto Encyclopedia of Genes and Genomes|117.0" --log-path $LOG_DIR/kegg-load.log  --commit 

# REACTOME
#get the reactome file 
wget -O $DATA_DIR/Pathways/Ensembl2Reactome.txt https://download.reactome.org/97/Ensembl2Reactome.txt

# load the xdbr
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/genes/pathways/reactome_xdb.json  --log-path $LOG_DIR/reactome-xdbr.log --commit


# load the pathway memberships
# --fail-on-missing-genes
# note: unit of load is a pathway so batch size needs to be < 100 to ensure not loading too many pathway associations in one commit
runpipe-plugin --plugin ReactomeLoaderPlugin --file $DATA_DIR/Pathways/Ensembl2Reactome.txt --batch-size 50 --xdbref "Reactome|V97" --log-path $LOG_DIR/reactome-load.log  --commit 

