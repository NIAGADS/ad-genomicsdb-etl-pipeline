mkdir -p $DATA_DIR/variants/adsp/compact

# use s3_extract_vcf_fields to query s3 bucket and pipe smaller files to target directory

# run rep
$PROJECT_DIR/niagads-pylib/projects/variant-annotator/bin/run_vep_parallel.sh $DATA_DIR/variants/adsp/compact --max-parallel 5 --fork 15 --buffer-size 50000 --stats