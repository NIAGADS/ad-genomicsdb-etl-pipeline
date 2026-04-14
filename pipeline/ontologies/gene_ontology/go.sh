mkdir -p $DATA_DIR/ontologies/go
mkdir -p $LOG_DIR/ontologies/go

wget -O $DATA_DIR/ontologies/go-basic.owl https://purl.obolibrary.org/obo/go/go-basic.owl

# for graph reasoner
# https://purl.obolibrary.org/obo/go/extensions/go-plus.owl

# load external database reference

runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/ontologies/gene_ontology/go_xdbr.json  --log-path $LOG_DIR/ontologies/go-xdbr.log --commit

# load ontology

runpipe-plugin --plugin OntologyTermLoader --xdbref "Gene Ontology|2026-03-25" --file $DATA_DIR/ontologies/go-basic.owl --batch-size 1000 --log-path $LOG_DIR/ontologies/go-load.log --commit


# ========= ECO

wget -O $DATA_DIR/ontologies/eco.owl https://raw.githubusercontent.com/evidenceontology/evidenceontology/269fa799fa9b89598265af640b60570de233f3c6/eco.owl


# load external database reference

runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/ontologies/gene_ontology/eco_xdbr.json  --log-path $LOG_DIR/ontologies/eco-xdbr.log --commit

# load ontology

runpipe-plugin --plugin OntologyTermLoader --xdbref "Evidence and Conclusion Ontology|v2026-04-05" --file $DATA_DIR/ontologies/eco.owl --log-path $LOG_DIR/ontologies/eco-load.log --commit
