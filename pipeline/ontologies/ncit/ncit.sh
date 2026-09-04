wget -O $DATA_DIR/ontologies/ncit.owl http://purl.obolibrary.org/obo/ncit.owl #done


# load external database reference
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/ontologies/hp/ncit_xdbr.json --log-path $DATA_DIR/ontologies/ncit-xdbr.log --commit

# load ontology
runpipe-plugin --plugin OntologyTermLoader --xdbref "National Cancer Institute Thesaurus|v2026-03-19" --file $DATA_DIR/ontologies/ncit.owl --embedding-batch-size 512 --batch-size 1000 --log-path $DATA_DIR/ontologies/ncit-load.log --commit