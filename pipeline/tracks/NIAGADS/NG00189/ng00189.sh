source $CONFIG_DIR/tracks/NIAGADS/NG00189/ng00189.env

mkdir -p $DATA_DIR/tracks/${COLLECTION_KEY}/logs

runpipe-plugin --plugin CollectionLoader --name "${COLLECTION_NAME}" --description "${FLATTENED_COLLECTION_DESCRIPTION}" --key ${COLLECTION_KEY} --source-id ${COLLECTION_KEY} --xdbref 'NIAGADS-DSS|current' --log-path $DATA_DIR/tracks/${COLLECTION_KEY}/logs/load-collection.log --commit

source $CONFIG_DIR/tracks/NIAGADS/rename_data_files.sh

./$PROJECT_DIR/niagads-pylib/projects/variant-annotator/bin/load_niagads_variant_associations.sh ${COLLECTION_KEY} --embedding-force-cpu --commit

$PROJECT_DIR/niagads-pylib/projects/variant-annotator/bin/run_vep_parallel.sh $DATA_DIR/tracks/${COLLECTION_KEY}/data --max-parallel 5 --fork 15 --buffer-size 50000 --stats
