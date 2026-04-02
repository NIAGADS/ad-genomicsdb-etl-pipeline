# get fetchChromSizes script
wget https://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/fetchChromSizes
chmod +x fetchChromSizes

# fetch chrm sizes
mkdir -p $DATA_DIR/reference
 ./fetchChromSizes hg38 > $DATA_DIR/reference/hg38_chrms.txt
 
 # load genome reference
 mkdir -p $LOG_DIR/reference/genome
 runpipe-plugin --plugin ChromosomeMapLoader --file $DATA_DIR/reference/hg38_chrms.txt --log-path $LOG_DIR/reference/genome/chm-map.log --commit

 # load interval bins
 runpipe-plugin --plugin IntervalBinGenerator --log-path $LOG_DIR/reference/genome/interval-bin.log --commit