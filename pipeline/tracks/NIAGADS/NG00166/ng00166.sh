source $CONFIG_DIR/tracks/NIAGADS/NG00166/ng00166.env

mkdir -p $DATA_DIR/tracks/${COLLECTION_KEY}/logs

runpipe-plugin --plugin CollectionLoader --name "${COLLECTION_NAME}" --description "${FLATTENED_COLLECTION_DESCRIPTION}" --key ${COLLECTION_KEY} --source-id ${COLLECTION_KEY} --xdbref 'NIAGADS-DSS|current' --log-path $DATA_DIR/tracks/${COLLECTION_KEY}/logs/load-collection.log --commit

# test
# runpipe-plugin --plugin GWASTrackLoader --genome-build GRCh38 --seqrepo-data-proxy $DATA_DIR/shared/seqrepo/2024-12-20 --xdbref 'NIAGADS-DSS|current' --collection ${COLLECTION_KEY} --metadata-file $CONFIG_DIR/tracks/NIAGADS/${COLLECTION_KEY}/metadata/${COLLECTION_KEY}_04BE648F_STD_OA_metadata.json --data-file $DATA_DIR/tracks/${COLLECTION_KEY}/data/${COLLECTION_KEY}_04BE648F_STD.tsv.gz --log-path $LOG_DIR/load-NG00166_04BE648F.log --batch-size 5000 --embedding-force-cpu --commit

# NOTE: is-zero-based flag should be temporary; these files need to be regenerated as they should be 1-based
./$PROJECT_DIR/niagads-pylib/projects/variant-annotator/bin/load_niagads_variant_associations.sh NG00166 --embedding-force-cpu --is-zero-based --commit

# run vep on unnotated vcfs
$PROJECT_DIR/niagads-pylib/projects/variant-annotator/bin/update_vcf_header.sh $DATA_DIR/tracks/${COLLECTION_KEY}/data
$PROJECT_DIR/niagads-pylib/projects/variant-annotator/bin/run_vep_parallel.sh $DATA_DIR/tracks/${COLLECTION_KEY}/data --max-parallel 5 --fork 15 --buffer-size 50000 --stats --skip-reheader --skip-filter

$PROJECT_DIR/ad-genomicsdb-etl-pipeline/pipeline/variants/parallel_load_vep.sh --vep-result-dir $DATA_DIR/tracks/${COLLECTION_KEY}/data --num-parallel 1 --embedding-batch-size 1024 --commit

