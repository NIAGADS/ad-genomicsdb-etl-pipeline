# set up env
mkdir -p $DATA_DIR/gene/reference
mkdir -p $LOG_DIR/gene/reference

# Ensembl GFF3 - Gene Models
wget -O $DATA_DIR/gene/reference/Homo_sapiens.GRCh38.115.gff3.gz https://ftp.ensembl.org/pub/current/gff3/homo_sapiens/Homo_sapiens.GRCh38.115.gff3.gz
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/genes/reference/ensembl_gene_xdbr.json  --log-path $LOG_DIR/gene/reference/ensembl-gene-xdbr.log --commit
runpipe-plugin --plugin EnsemblGFF3Loader --file $DATA_DIR/gene/reference/Homo_sapiens.GRCh38.115.gff3.gz --xdbref "Ensembl Gene Annotation|115/GRCh38" --so-xdbref "Sequence Ontology|2024-11-18" --log-path $LOG_DIR/gene/reference/ensembl-gff3-load.log --commit

# HGNC annotations
wget -O $DATA_DIR/gene/reference/hgnc_complete_set.json storage.googleapis.com/public-download-files/hgnc/json/json/hgnc_complete_set.json
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/genes/reference/hgnc_xdbr.json  --log-path $LOG_DIR/gene/reference/hgnc-xdbr.log --commit

