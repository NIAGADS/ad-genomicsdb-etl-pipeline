#!/bin/bash

BATCH_SIZE=100000
VEP_RESULT_DIR="$1"
NUM_PARALLEL="${2:-4}"
COMMIT_FLAG="${3:-}"

if [[ "$COMMIT_FLAG" == "commit" ]]; then
  COMMIT_FLAG="--commit"
fi

process_vep() {
    local vep_result_file="$1"
    local filename=$(basename "$vep_result_file")

    echo "loading $filename"
    runpipe-plugin --plugin VEPAnnotationLoader  \
        --file "$vep_result_file" \
        --log-path ${VEP_RESULT_DIR}/${filename}.log \
        --embedding-batch-size 512 \
        --embedding-force-cpu \
        --skip-summarization
        --batch-size $BATCH_SIZE $COMMIT_FLAG
}

export -f process_vep
export VEP_RESULT_DIR
export COMMIT_FLAG
export DATA_DIR
export BATCH_SIZE

find "$VEP_RESULT_DIR" -maxdepth 1 -name "*.json.gz" -type f -print0 | xargs -0 -P "$NUM_PARALLEL" -I {} bash -c 'process_vep "$@"' _ {}
