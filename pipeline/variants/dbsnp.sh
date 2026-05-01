# set up env
export FILE_PATH=$DATA_DIR/variants
export LOG_PATH=$DATA_DIR/variants/logs
mkdir -p $FILE_PATH
mkdir -p $LOG_PATH


# get dbsnp
mkdir $FILE_PATH/dbsnp
wget -O $FILE_PATH/dbsnp/release_notes.txt https://ftp.ncbi.nih.gov/snp/latest_release/release_notes.txt
wget -O $FILE_PATH/GCF_000001405.40.gz https://ftp.ncbi.nih.gov/snp/latest_release/VCF/GCF_000001405.40.gz
wget -O $FILE_PATH/GCF_000001405.40.gz.md5 https://ftp.ncbi.nih.gov/snp/latest_release/VCF/GCF_000001405.40.gz.md5
wget -O $FILE_PATH/CHECKSUMS https://ftp.ncbi.nih.gov/snp/latest_release/VCF/CHECKSUMS

# split by chrm
./split_vcf_by_chr.sh  $FILE_PATH/GCF_000001405.40.gz

# ----- run vep ---
# spin up docker in `niagads-pylib/variant_annotator` project
# install cache following instructions

