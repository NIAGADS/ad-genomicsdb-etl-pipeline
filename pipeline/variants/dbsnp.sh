
# get dbsnp
mkdir -p $DATA_DIR/variants/dbsnp/orig
wget -O $DATA_DIR/variants/dbsnp/orig/release_notes.txt https://ftp.ncbi.nih.gov/snp/latest_release/release_notes.txt
wget -O $DATA_DIR/variants/dbsnp/orig/GCF_000001405.40.gz https://ftp.ncbi.nih.gov/snp/latest_release/VCF/GCF_000001405.40.gz
wget -O $DATA_DIR/variants/dbsnp/orig/GCF_000001405.40.gz.md5 https://ftp.ncbi.nih.gov/snp/latest_release/VCF/GCF_000001405.40.gz.md5
wget -O $DATA_DIR/variants/dbsnp/orig/CHECKSUMS https://ftp.ncbi.nih.gov/snp/latest_release/VCF/CHECKSUMS

# ====== load xdbr
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/variants/dbsnp_xdbr.json  --log-path $LOG_DIR/variants/dbsnp-xdbr.log --commit
# dbSNP|157

# ====== load variants from the dbSNP VCF

# split by chrm
$PROJECT_DIR/niagads-pylib/projects/variant-annotator/bin/split_vcf_by_chr.sh  $DATA_DIR/variants/dbsnp/orig/GCF_000001405.40.gz

# TODO: add the call the rename script in variant-annotator/bin
# mv the chrN.vcf files up a level
mv $DATA_DIR/variants/dbsnp/orig/chr*.vcf ../.

# TEST
# runpipe-plugin --plugin dbSNPVCFLoader --xdbref "dbSNP|157" --file $DATA_DIR/variants/dbsnp/chrY.vcf --seqrepo-data-proxy $DATA_DIR/shared/seqrepo/2024-12-20 --log-path $DATA_DIR/variants/dbsnp/chrY-test.log --batch-size 50000 --commit


$PROJECT_DIR/ad-genomicsdb-etl-pipeline/pipeline/variants/load_dbnp_vcfs.sh $DATA_DIR/variants/dbsnp 25 commit

# build indexes
docker run --rm -it --network host -v $PROJECT_DIR/niagads-pylib/projects/genomicsdb-schema-manager/sql/schemas/variant/tables/:/work postgres:18 psql -a -e $DATABASE_URI -f /work/create_variant_lookup_indexes.sql




# ====== load merged variants
wget -O $DATA_DIR/variants/dbsnp/refsnp-merged.json.bz2 https://ftp.ncbi.nih.gov/snp/latest_release/JSON/refsnp-merged.json.bz2
wget -O $DATA_DIR/variants/dbsnp/refsnp-merged.json.bz2.md5 https://ftp.ncbi.nih.gov/snp/latest_release/JSON/refsnp-merged.json.bz2.md5

# start the seqrepo docker container
docker compose --file $PROJECT_DIR/niagads-pylib/projects/variant-annotator/docker-compose.yaml up -d seqrepo-rest-service

runpipe-plugin --plugin RefSNPMergeHistory --xdbref "dbSNP|157" --file $DATA_DIR/variants/dbsnp/refsnp-merged.json.bz2 --log-path $LOG_DIR/variants/dbsnp-merges-load.log --commit

