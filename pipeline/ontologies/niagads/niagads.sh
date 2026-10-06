wget -O $DATA_DIR/ontologies/niagads/niagads.obo https://raw.githubusercontent.com/NIAGADS/niagads-ontology/refs/heads/main/obo/niagads.obo


# load external database reference
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/ontologies/niagads/niagads_xdbr.json --log-path $DATA_DIR/ontologies/niagads/niagads-xdbr.log --commit

# load ontology
runpipe-plugin --plugin OntologyTermLoader --xdbref "NIAGADS Ontology|current" --file $DATA_DIR/ontologies/niagads/niagads.obo