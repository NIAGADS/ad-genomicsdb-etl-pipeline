#!/bin/bash

VCF_DIR="$1"
NUM_PARALLEL="${2:-4}"
COMMIT_FLAG="${3:-}"

if [[ "$COMMIT_FLAG" == "commit" ]]; then
  COMMIT_FLAG="--commit"
fi

process_vcf() {
    local vcf_file="$1"
    local filename=$(basename "$vcf_file")

    echo "loading $filename"
    runpipe-plugin --plugin dbSNPVCFLoader --xdbref "dbSNP|157" \
        --file "$vcf_file" --log-path ${VCF_DIR}/${filename%.vcf}.log \
        --batch-size 10000 $COMMIT_FLAG

    
}

export -f process_vcf
export VCF_DIR
export COMMIT_FLAG

find "$VCF_DIR" -maxdepth 1 -name "*.vcf" -type f -print0 | xargs -0 -P "$NUM_PARALLEL" -I {} bash -c 'process_vcf "$@"' _ {}
