# fetch file
wget -O $DATA_DIR/ontologies/so-simple.owl https://raw.githubusercontent.com/The-Sequence-Ontology/SO-Ontologies/refs/heads/master/Ontology_Files/so-simple.owl

# load external database reference

runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/ontologies/sequence_ontology/so_xdb.json  --log-path $LOG_DIR/ontologies/so-xdbr.log --commit

# load ontology

runpipe-plugin --plugin OntologyTermLoader --xdbref "Sequence Ontology|2024-11-18" --file $DATA_DIR/ontologies/so-simple.owl --batch-size 1000 --log-path $LOG_DIR/ontologies/so-load.log
