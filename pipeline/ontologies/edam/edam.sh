
wget -O $DATA_DIR/ontologies/EDAM_stable.owl https://edamontology.org/EDAM_stable.owl

# for graph reasoner

# load external database reference

runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/ontologies/edam/edam_xdbr.json  --log-path $DATA_DIR/ontologies/edam-xdbr.log --commit

# load ontology

runpipe-plugin --plugin OntologyTermLoader --xdbref "EDAM Ontology|1.25" --file $DATA_DIR/ontologies/EDAM_stable.owl --embedding-batch-size 512 --batch-size 1000 --log-path $DATA_DIR/ontologies/edam-load.log --commit

