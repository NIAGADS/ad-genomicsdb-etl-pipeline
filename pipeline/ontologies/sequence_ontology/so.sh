# fetch file
wget -O $DATA_DIR/ontologies/so-simple.owl https://raw.githubusercontent.com/The-Sequence-Ontology/SO-Ontologies/refs/heads/master/Ontology_Files/so-simple.owl

# load external database reference

runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/ontologies/sequence_ontology/so_xdb.json  --log-path $LOG_DIR/ontologies/sequence_ontology/logs/so-xdbr.log --commit

# load ontology

