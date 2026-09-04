
wget -O $DATA_DIR/ontologies/hp.owl http://purl.obolibrary.org/obo/hp.owl #done

# load external database reference
#done
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/ontologies/hp/hp_xdbr.json --log-path $DATA_DIR/ontologies/hp-xdbr.log --commit

# load ontology

runpipe-plugin --plugin OntologyTermLoader --xdbref "Human Phenotype Ontology|v2026-06-23" --file $DATA_DIR/ontologies/hp.owl --embedding-batch-size 512 --batch-size 1000 --log-path $DATA_DIR/ontologies/hp-load.log --commit
