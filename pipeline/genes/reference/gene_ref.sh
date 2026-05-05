# set up env
export FILE_PATH=$DATA_DIR/gene/reference
export LOG_PATH=$LOG_DIR/gene/reference
mkdir -p $FILE_PATH
mkdir -p $LOG_PATH

# ====== Ensembl GFF3 - Gene Models

# -- fetch files
wget -O  $FILE_PATH/Homo_sapiens.GRCh38.115.gff3.gz https://ftp.ensembl.org/pub/current/gff3/homo_sapiens/Homo_sapiens.GRCh38.115.gff3.gz

# -- xdbr
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/genes/reference/ensembl_gene_xdbr.json  --log-path $LOG_PATH/ensembl-xdbr.log --commit

# --- verify biotypes
runpipe-plugin --plugin EnsemblGFF3Loader --file $FILE_PATH/Homo_sapiens.GRCh38.115.gff3.gz --xdbref "Ensembl Gene Annotation|115/GRCh38" --so-xdbref "Sequence Ontology|2024-11-18" --log-path $LOG_PATH/ensembl-verify-biotypes.log --verify_biotypes --verbose

# add synonyms to SO to support obsolete or custom terms found in Ensembl GFF3 file
runpipe-plugin --plugin XMLRecordLoader --file $CONFIG_DIR/ontologies/sequence_ontology/ensembl_syn_updates.xml --log-path $LOG_DIR/ontologies/ensembl-syn-updates.log --commit

# -- load
runpipe-plugin --plugin EnsemblGFF3Loader --file $FILE_PATH/Homo_sapiens.GRCh38.115.gff3.gz --xdbref "Ensembl Gene Annotation|115/GRCh38" --so-xdbref "Sequence Ontology|2024-11-18" --log-path $LOG_PATH/ensembl-load.log --batch-size 50 --commit


# ====== HGNC annotations
wget -O  $DATA_DIR/gene/reference/hgnc_complete_set.json storage.googleapis.com/public-download-files/hgnc/json/json/hgnc_complete_set.json
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/genes/reference/hgnc_xdbr.json  --log-path $LOG_DIR/gene/reference/hgnc-xdbr.log --commit

    # find the right xdbr
    # runpipe-xdb-lookup --xdb HGNC -> HGNC Gene Nomenclature|2026-04-01

# verify the xrefs
runpipe-plugin --plugin HGNCXRefLoader --file $DATA_DIR/gene/reference/hgnc_complete_set.json --xdbref  "HGNC Gene Nomenclature|2026-04-01" --log-path $LOG_DIR/gene/reference/hgnc-verify.log --mode DRY_RUN --verify-xref-keys

# load
runpipe-plugin --plugin HGNCXRefLoader --file $DATA_DIR/gene/reference/hgnc_complete_set.json --xdbref  "HGNC Gene Nomenclature|2026-04-01" --log-path $LOG_DIR/gene/reference/hgnc-load.log --commit

# ====== UniprotKB ID mapping - basically there are > 78k genes from Ensemble, but only 20k are annotated by UniProt IDS in HGNC

# need a file with ensembl ids for lookup against UniProt API
# runpipe-export --table gene --schema gene --fields source_id --output $DATA_DIR/gene/reference/loaded_ensembl_genes.txt

UNIPROT_FILE_PATH=$DATA_DIR/gene/reference/HUMAN_9606_idmapping.dat.gz
UNIPROT_LOG_PREFIX=$LOG_DIR/gene/reference/uniprot

# found the download
wget -O $UNIPROT_FILE_PATH https://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/idmapping/by_organism/HUMAN_9606_idmapping.dat.gz

# -- xdbr
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/genes/reference/uniprotkb_xdbr.json  --log-path $UNIPROT_LOG_PREFIX-xdbr.log --commit

    # runpipe-xdb-lookup --xdb uniprot -> UniProtKB|2026-01-28

runpipe-plugin --plugin UniProtKBIDLoader --file $UNIPROT_FILE_PATH --xdbref "UniProtKB|2026-01-28" --log-path $UNIPROT_LOG_PREFIX-load.log --commit

# ====== PAN-GO Annotations
wget -O $FILE_PATH/functionome_release.gaf.gz   -U "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"  --referer="https://functionome.geneontology.org" https://functionome.geneontology.org/download/functionome_release.gaf.gz 


# -- xdbr
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/genes/reference/pan_go_xdbr.json  --log-path $LOG_PATH/pan-go-xdbr.log --commit

# -- load
runpipe-plugin --plugin GAFLoader --file $FILE_PATH/functionome_release.gaf.gz --xdbref "PAN-GO|2.0" --go-xdbref "Gene Ontology|2026-03-25" --eco-xdbref "Evidence and Conclusion Ontology|v2026-04-05" --log-path $LOG_PATH/pan-go-load.log --commit