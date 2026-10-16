# fetch from website


# load the xdbr
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/genes/listsls/gvc_xdbr.json  --log-path $DATA_DIR/gene/gvc/gvc-xdbr.log --commit


runpipe-plugin --plugin GVCGenesLoader --file $DATA_DIR/gene/gvc/adsp_gene_data_2026-10-13.csv --log-path $DATA_DIR/gene/gvc/gvc-load.log --xdbref 'ADSP-GVC|current' --commit