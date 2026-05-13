#!/bin/bash

# Load dbSNP variants from all VCF files in a directory
# Usage: ./load_dbsnp_all_chroms.sh --directory <path> --batch-size <size> --seqrepo-batch-size <size> [--commit]

set -e

# Default values
DIRECTORY=""
BATCH_SIZE="50000"
SEQREPO_BATCH_SIZE="250"
COMMIT_FLAG=""

# Get external database reference (assumes dbSNP|157 format)
XDBREF="dbSNP|157"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --dir)
            DIRECTORY="$2"
            shift 2
            ;;
        --batch-size)
            BATCH_SIZE="$2"
            shift 2
            ;;
        --seqrepo-batch-size)
            SEQREPO_BATCH_SIZE="$2"
            shift 2
            ;;
        --commit)
            COMMIT_FLAG="--commit"
            shift
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 --dir <path> --batch-size <size> --seqrepo-batch-size <size> [--commit]"
            exit 1
            ;;
    esac
done

# Validate required arguments
if [ -z "$DIRECTORY" ]; then
    echo "Error: --dir is required"
    echo "Usage: $0 --dir <path> --batch-size <size> --seqrepo-batch-size <size> [--commit]"
    exit 1
fi

if [ ! -d "$DIRECTORY" ]; then
    echo "Error: Directory does not exist: $DIRECTORY"
    exit 1
fi


# Counter for processed files
PROCESSED=0
FAILED=0

# Process each VCF file in the directory
for vcf_file in "$DIRECTORY"/*.vcf; do
    # Skip if no VCF files found
    if [ ! -f "$vcf_file" ]; then
        continue
    fi

    filename=$(basename "$vcf_file")
    log_file="${DIRECTORY}/${filename%.vcf}-load.log"

    echo "Processing: $filename"
    echo "Log file: $log_file"

    # Run the plugin loader
    if runpipe-plugin \
        --plugin dbSNPVCFLoader \
        --xdbref "$XDBREF" \
        --file "$vcf_file" \
        --log-path "$log_file" \
        --batch-size "$BATCH_SIZE" \
        --seqrepo-batch-size "$SEQREPO_BATCH_SIZE" \
        $COMMIT_FLAG; then
        ((PROCESSED++))
        echo "✓ Successfully loaded: $filename"
    else
        ((FAILED++))
        echo "✗ Failed to load: $filename (see $log_file for details)"
    fi

    echo ""
done

# Summary
echo "=========================================="
echo "Load Summary"
echo "=========================================="
echo "Directory: $DIRECTORY"
echo "Batch size: $BATCH_SIZE"
echo "Seqrepo batch size: $SEQREPO_BATCH_SIZE"
echo "Commit mode: ${COMMIT_FLAG:-disabled}"
echo ""
echo "Successfully processed: $PROCESSED"
echo "Failed: $FAILED"
echo "=========================================="

# Exit with error if any files failed
if [ $FAILED -gt 0 ]; then
    exit 1
fi

exit 0
