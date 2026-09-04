
wget -O $DATA_DIR/ontologies/mondo.owl http://purl.obolibrary.org/obo/mondo.owl #done

# load external database reference
#done
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/ontologies/mondo/mondo_xdbr.json --log-path $DATA_DIR/ontologies/mondo-xdbr.log --commit

# load ontology

runpipe-plugin --plugin OntologyTermLoader --xdbref "" --file $DATA_DIR/ontologies/mondo.owl --embedding-batch-size 512 --batch-size 1000 --log-path $DATA_DIR/ontologies/mondo-load.log --commit
