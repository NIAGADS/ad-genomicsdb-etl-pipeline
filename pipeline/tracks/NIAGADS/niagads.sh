
# load external database reference
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/datasets/NIAGADS/niagads_xdbr.json --log-path $DATA_DIR/NIAGADS/niagads-xdbr.log --commit

runpipe-plugin --plugin JSONTrackLoader --file $CONFIG_DIR/datasets/NIAGADS/NG000166/metadata/NG00166_04BE648F_STD_OA_metadata.json --log-path $DATA_DIR/NIAGADS/niagads-xdbr.log