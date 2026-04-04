# set up env
mkdir -p $DATA_DIR/gene/reference
mkdir -p $LOG_DIR/gene/reference

# fetch ensembl gff3 file
wget -O $DATA_DIR/gene/reference/Homo_sapiens.GRCh38.115.gff3.gz https://ftp.ensembl.org/pub/current/gff3/homo_sapiens/Homo_sapiens.GRCh38.115.gff3.gz

# load external database reference
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/genes/reference/ensembl_gene_xdbr.json  --log-path $LOG_DIR/gene/reference/ensembl-gene-xdbr.log --commit

# load the gene reference
runpipe-plugin --plugin EnsemblGFF3Loader --file $DATA_DIR/gene/reference/Homo_sapiens.GRCh38.115.gff3.gz --xdbref "Ensembl Gene Annotation|115/GRCh38" --so-xdbref "Sequence Ontology|2024-11-18" --log-path $LOG_DIR/gene/reference/ensembl-gff3-load.log --commit