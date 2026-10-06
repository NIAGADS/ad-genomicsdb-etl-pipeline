wget -O $DATA_DIR/ontologies/symp.owl http://purl.obolibrary.org/obo/symp.owl

# load external database reference
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/ontologies/symp/symp_xdbr.json --log-path $DATA_DIR/ontologies/symp-xdbr.log --commit

# load ontology
runpipe-plugin --plugin OntologyTermLoader --xdbref "Symptom Ontology|v2026-07-30"  --file $DATA_DIR/ontologies/symp.owl --embedding-batch-size 512 --batch-size 1000 --log-path $DATA_DIR/ontologies/symp-load.log --commit