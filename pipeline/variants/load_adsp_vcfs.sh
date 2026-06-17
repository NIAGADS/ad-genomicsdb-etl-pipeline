#!/bin/bash

XDBREF="ADSP R5 58K WGS: SNVs and short INDELs|R5"
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
    runpipe-plugin --plugin ADSPVCFLoader --xdbref "${XDBREF}" \
        --file "$vcf_file" \
        --seqrepo-data-proxy $DATA_DIR/shared/seqrepo/2024-12-20 \
        --log-path ${VCF_DIR}/${filename%.vcf.gz}.log \
        --batch-size 100000 \
        --no-updates $COMMIT_FLAG
}

export -f process_vcf
export VCF_DIR
export COMMIT_FLAG
export DATA_DIR
export XDBREF

find "$VCF_DIR" -maxdepth 1 -name "*.vcf.gz" -type f -print0 | xargs -0 -P "$NUM_PARALLEL" -I {} bash -c 'process_vcf "$@"' _ {}