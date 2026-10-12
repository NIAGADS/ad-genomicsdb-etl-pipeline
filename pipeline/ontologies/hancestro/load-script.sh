wget -O $DATA_DIR/ontologies/hancestro.owl https://raw.githubusercontent.com/EBISPOT/hancestro/refs/heads/main/hancestro.owl

# load external database reference
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/ontologies/hancestro/xdbr.json --log-path $DATA_DIR/ontologies/hancestro-xdbr.log --commit

# load ontology
runpipe-plugin --plugin OntologyTermLoader --xdbref "HANCESTRO|v2025-10-14"  --file $DATA_DIR/ontologies/hancestro.owl --embedding-batch-size 128 --batch-size 1000 --log-path $DATA_DIR/ontologies/hancestro-load.log --embedding-force-cpu --commit