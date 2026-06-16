#!/bin/bash

XDBREF="ADSP R5 58K WGS: SNVs and short INDELs|R5"
VCF_DIR="$1"
MAX_PARALLEL_CHROMOSOMES="${2:-4}"
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
        --batch-size 100000 $COMMIT_FLAG
}


export -f process_vcf
export VCF_DIR
export COMMIT_FLAG
export DATA_DIR
export XDBREF

process_chromosome() {
    local chromosome="$1"
    shift

    local vcf_file
    for vcf_file in "$@"; do
        process_vcf "$vcf_file"
    done
}

declare -A chromosome_files
chromosomes=()

while IFS= read -r -d '' vcf_file; do
    filename=$(basename "$vcf_file")
    [[ "$filename" =~ (chr[^_]+)_ ]] || continue
    chromosome="${BASH_REMATCH[1]}"

    if [[ -z "${chromosome_files[$chromosome]+set}" ]]; then
        chromosomes+=("$chromosome")
    fi

    chromosome_files[$chromosome]+="${vcf_file}"$'\n'
done < <(find "$VCF_DIR" -maxdepth 1 -name "*.vcf.gz" -type f -print0)

mapfile -t chromosomes < <(printf '%s\n' "${chromosomes[@]}" | sort)

for chromosome in "${chromosomes[@]}"; do
    mapfile -t files < <(printf '%s' "${chromosome_files[$chromosome]}" | sort)

    while (( $(jobs -pr | wc -l) >= MAX_PARALLEL_CHROMOSOMES )); do
        wait -n
    done

    process_chromosome "$chromosome" "${files[@]}" &
done

wait
