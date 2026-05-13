
# get dbsnp
mkdir $DATA_DIR/variants/dbsnp
wget -O $DATA_DIR/variants/dbsnp/release_notes.txt https://ftp.ncbi.nih.gov/snp/latest_release/release_notes.txt
wget -O $DATA_DIR/variants/GCF_000001405.40.gz https://ftp.ncbi.nih.gov/snp/latest_release/VCF/GCF_000001405.40.gz
wget -O $DATA_DIR/variants/GCF_000001405.40.gz.md5 https://ftp.ncbi.nih.gov/snp/latest_release/VCF/GCF_000001405.40.gz.md5
wget -O $DATA_DIR/variants/CHECKSUMS https://ftp.ncbi.nih.gov/snp/latest_release/VCF/CHECKSUMS

# ====== load xdbr
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/variants/dbsnp_xdbr.json  --log-path $LOG_DIR/variants/dbsnp-xdbr.log --commit
# dbSNP|157

# ====== load variants

# split by chrm
$PROJECT_DIR/niagads-pylib/projects/variant-annotator/bin/split_vcf_by_chr.sh  $DATA_DIR/variants/GCF_000001405.40.gz

runpipe-plugin --plugin dbSNPVCFLoader --xdbref "dbSNP|157" --file $DATA_DIR/variants/dbsnp/chrY.vcf --log-path $LOG_DIR/variants/dbsnp-chrY-load.log --batch-size 50000 --seqrepo-batch-size 250 --commit




# ====== load merged variants
wget -O $DATA_DIR/variants/dbsnp/refsnp-merged.json.bz2 https://ftp.ncbi.nih.gov/snp/latest_release/JSON/refsnp-merged.json.bz2
wget -O $DATA_DIR/variants/dbsnp/refsnp-merged.json.bz2.md5 https://ftp.ncbi.nih.gov/snp/latest_release/JSON/refsnp-merged.json.bz2.md5

# start the seqrepo docker container
docker compose --file $PROJECT_DIR/niagads-pylib/projects/variant-annotator/docker-compose.yaml up -d seqrepo-rest-service

runpipe-plugin --plugin RefSNPMergeHistory --xdbref "dbSNP|157" --file $DATA_DIR/variants/dbsnp/refsnp-merged.json.bz2 --log-path $LOG_DIR/variants/dbsnp-merges-load.log --commit

