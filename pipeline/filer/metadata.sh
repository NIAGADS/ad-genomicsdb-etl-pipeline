
# load the xdbr
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/filer/filer_xdbref.json  --log-path $DATA_DIR/logs/filer-xdbr.log --commit

# runpipe-xdb-lookup --xdb FILER
# --xdbref "NIAGADS Functional Genomics Repository|2.0"

# load the metadata
runpipe-plugin --plugin FILERTrackLoader --xdbref "NIAGADS Functional Genomics Repository|2.0" --filer-genome-build hg38 --log-path $DATA_DIR/logs/filer-metadata-track-load.log --template-file https://tf.lisanwanglab.org/FILER2/metadata/filer2.latest.hg38.template.with_downloadOnly_indication  --commit