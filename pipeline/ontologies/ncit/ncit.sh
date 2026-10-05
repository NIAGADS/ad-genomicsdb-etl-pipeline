wget -O $DATA_DIR/ontologies/ncit.owl.zip https://evs.nci.nih.gov/ftp1/NCI_Thesaurus/Thesaurus_26.09d.OWL.zip

unzip $DATA_DIR/ontologies/ncit.owl.zip
mv $DATA_DIR/ontologies/Thesaurus.owl $DATA_DIR/ontologies/ncit.owl


# load external database reference
#done
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/ontologies/ncit/ncit_xdbr.json --log-path $DATA_DIR/ontologies/ncit-xdbr.log --commit

# load ontology
runpipe-plugin --plugin OntologyTermLoader --xdbref "National Cancer Institute Thesaurus|26.09.d" --file $DATA_DIR/ontologies/ncit.owl --embedding-batch-size 512 --batch-size 1000 --log-path $DATA_DIR/ontologies/ncit-load.log --commit