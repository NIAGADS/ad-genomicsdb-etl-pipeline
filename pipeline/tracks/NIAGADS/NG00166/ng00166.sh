source $CONFIG_DIR/tracks/NIAGADS/NG00166/ng00166.env

runpipe-plugin --plugin CollectionLoader --name "${COLLECTION_NAME}" --description "${FLATTENED_COLLECTION_DESCRIPTION}" --key ${COLLECTION_KEY} --source-id ${COLLECTION_KEY} --xdbref 'NIAGADS-DSS|current' --log-path $DATA_DIR/tracks/NG00166/load-collection.log --commit

# rename pvalue only files to _std_oa files
source $CONFIG_DIR/tracks/NIAGADS/rename_data_files.sh

runpipe-plugin --plugin GWASTrackLoader --genome-build GRCh38 --seqrepo-data-proxy $DATA_DIR/shared/seqrepo/2024-12-20 --xdbref 'NIAGADS|current' --collection ${COLLECTION_KEY} --metadata-file $CONFIG_DIR/tracks/NIAGADS/${COLLECTION_KEY}/metadata/${COLLECTION_KEY}_04BE648F_STD_OA_metadata.json --data-file $DATA_DIR/tracks/${COLLECTION_KEY}/data/${COLLECTION_KEY}_04BE648F_STD_OA.tsv.gz --log-path $LOG_DIR/04BE648F.log --batch-size 5000 --embedding-force-cpu --commit
