# get fetchChromSizes script
wget https://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/fetchChromSizes
chmod +x fetchChromSizes

# fetch chrm sizes
mkdir -p $DATA_DIR/reference
 ./fetchChromSizes hg38 > $DATA_DIR/reference/hg38_chrms.txtls
 