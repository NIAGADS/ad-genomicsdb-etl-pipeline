
wget -O $DATA_DIR/ontologies/uberon.owl http://purl.obolibrary.org/obo/uberon.owl
wget -O $DATA_DIR/ontologies/cl.owl http://purl.obolibrary.org/obo/cl.owl
wget -O $DATA_DIR/ontologies/clo.owl http://purl.obolibrary.org/obo/clo.owl
# for graph reasoner

# load external database reference

runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/ontologies/biosamples/uberon_xdbr.json  --log-path $DATA_DIR/ontologies/uberon-xdbr.log --commit
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/ontologies/biosamples/cell_line_xdbr.json  --log-path $DATA_DIR/ontologies/cell_line-xdbr.log --commit
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/ontologies/biosamples/cell_xdbr.json  --log-path $DATA_DIR/ontologies/cell-xdbr.log --commit

# load ontology

runpipe-plugin --plugin OntologyTermLoader --xdbref "UBERON|v2026-04-01" --file $DATA_DIR/ontologies/uberon.owl --embedding-batch-size 512 --batch-size 1000 --log-path $DATA_DIR/ontologies/uberon-load.log --commit
runpipe-plugin --plugin OntologyTermLoader --xdbref "Cell Ontology|v2026-03-26" --file $DATA_DIR/ontologies/cl.owl --embedding-batch-size 512 --batch-size 1000 --log-path $DATA_DIR/ontologies/cell-load.log --commit
runpipe-plugin --plugin OntologyTermLoader --xdbref "Cell Line Ontology|2023-03-28" --file $DATA_DIR/ontologies/clo.owl --embedding-batch-size 512 --batch-size 1000 --log-path $DATA_DIR/ontologies/cell_line-load.log --commit


