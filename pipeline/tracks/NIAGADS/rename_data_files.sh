for file in $DATA_DIR/tracks/${COLLECTION_KEY}/data/*STD_pvalue_only.tsv.gz; do
    [ -e "$file" ] || continue
    new_name="${file%STD_pvalue_only.tsv.gz}STD_OA.tsv.gz"
    mv -- "$file" "$new_name"
done