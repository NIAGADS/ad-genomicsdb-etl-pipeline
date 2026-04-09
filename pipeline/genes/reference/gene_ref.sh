# set up env
mkdir -p $DATA_DIR/gene/reference
mkdir -p $LOG_DIR/gene/reference

# ====== Ensembl GFF3 - Gene Models

# -- fetch files
GFF3_FILE_PATH=$DATA_DIR/gene/reference/Homo_sapiens.GRCh38.115.gff3.gz
wget -O  $GFF3_FILE_PATH https://ftp.ensembl.org/pub/current/gff3/homo_sapiens/Homo_sapiens.GRCh38.115.gff3.gz

# -- xdbr
GFF3_LOG_PREFIX=$LOG_DIR/gene/reference/ensembl-gene
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/genes/reference/ensembl_gene_xdbr.json  --log-path $GFF3_LOG_PREFIX-xdbr.log --commit

# --- verify biotypes
runpipe-plugin --plugin EnsemblGFF3Loader --file $GFF3_FILE_PATH --xdbref "Ensembl Gene Annotation|115/GRCh38" --so-xdbref "Sequence Ontology|2024-11-18" --log-path $GFF3_LOG_PREFIX-verify-biotypes.log --verify_biotypes --verbose

# add synonyms to SO to support obsolete or custom terms found in Ensembl GFF3 file
runpipe-plugin --plugin XMLRecordLoader --file $CONFIG_DIR/ontologies/sequence_ontology/ensembl_syn_updates.xml --log-path $LOG_DIR/ontologies/ensembl-syn-updates.log --commit

# -- load
runpipe-plugin --plugin EnsemblGFF3Loader --file $GFF3_FILE_PATH --xdbref "Ensembl Gene Annotation|115/GRCh38" --so-xdbref "Sequence Ontology|2024-11-18" --log-path $GFF3_LOG_PREFIX-load.log --commit


# ====== HGNC annotations
HGNC_FILE_PATH=$DATA_DIR/gene/reference/hgnc_complete_set.json
HGNC_LOG_PREFIX=$LOG_DIR/gene/reference/hgnc
wget -O  $HGNC_FILE_PATH storage.googleapis.com/public-download-files/hgnc/json/json/hgnc_complete_set.json
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/genes/reference/hgnc_xdbr.json  --log-path $HGNC_LOG_PREFIX-xdbr.log --commit

    # find the right xdbr
    # runpipe-xdb-lookup --xdb HGNC -> HGNC Gene Nomenclature|2026-04-01

# verify the xrefs
runpipe-plugin --plugin HGNCXRefLoader --file $HGNC_FILE_PATH --xdbref  "HGNC Gene Nomenclature|2026-04-01" --log-path $HGNC_LOG_PREFIX-verify.log --mode DRY_RUN --verify-xref-keys

# load
runpipe-plugin --plugin HGNCXRefLoader --file $HGNC_FILE_PATH --xdbref  "HGNC Gene Nomenclature|2026-04-01" --log-path $HGNC_LOG_PREFIX-load.log --commit

# ====== UniprotKB ID mapping - basically there are > 78k genes from Ensemble, but only 20k are annotated by UniProt IDS in HGNC

# need a file with ensembl ids for lookup against UniProt API
# runpipe-export --table gene --schema gene --fields source_id --output $DATA_DIR/gene/reference/loaded_ensembl_genes.txt

UNIPROT_FILE_PATH=$DATA_DIR/gene/reference/HUMAN_9606_idmapping.dat.gz
UNIPROT_LOG_PREFIX=$LOG_DIR/gene/reference/uniprot

# found the download
wget -O $UNIPROT_FILE_PATH https://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/idmapping/by_organism/HUMAN_9606_idmapping.dat.gz

# -- xdbr