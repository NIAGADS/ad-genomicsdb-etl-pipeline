
wget -O $DATA_DIR/ontologies/doid.owl https://

# for graph reasoner

# load external database reference

runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/ontologies/doid/doid_xdbr.json --log-path $DATA_DIR/ontologies/doid-xdbr.log --commit

# load ontology

runpipe-plugin --plugin OntologyTermLoader --xdbref "" --curie_prefix  --file $DATA_DIR/ontologies/doid.owl --embedding-batch-size 512 --batch-size 1000 --log-path $DATA_DIR/ontologies/doid-load.log --commit


# add database_type_id to external database entry.  Not that this will have to be changed each time to get the term primary key from the database (b/c it is a foreign key field)
# necessary b/c this term comes from this ontology
#runpipe-plugin --plugin XMLRecordLoader --file $CONFIG_DIR/ontologies/doid/edam_dataset_type.xml --log-path $DATA_DIR/ontologies/edam-xdbr-updates.log --commit
