source ng00166.env

runpipe-plugin --plugin CollectionLoader --name "${COLLECTION_NAME}" --description "${FLATTENED_COLLECTION_DESCRIPTION}" --key ${COLLECTION_KEY} --source-id ${COLLECTION_KEY} --xdbref 'NIAGADS-DSS|current' --log-path $DATA_DIR/tracks/NG00166/load-collection.log --commit

runpipe-plugin --plugin GWASTrackLoader --collection ${COLLECTION_KEY} --metadata-file $CONFIG_DIR/datasets/NIAGADS/
