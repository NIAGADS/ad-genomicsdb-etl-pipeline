mkdir -p $DATA_DIR/ontologies/go
mkdir -p $LOG_DIR/ontologies/go

wget -O $DATA_DIR/ontologies/go https://purl.obolibrary.org/obo/go/go-basic.owl

# for graph reasoner
# https://purl.obolibrary.org/obo/go/extensions/go-plus.owl