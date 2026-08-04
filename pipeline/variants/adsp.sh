# WGS SNVS/INDELS --> from compact VCFS

mkdir -p $DATA_DIR/variants/adsp/compact

# use s3_extract_vcf_fields to query s3 bucket and pipe smaller files to target directory

# ===== run VEP
$PROJECT_DIR/niagads-pylib/projects/variant-annotator/bin/run_vep_parallel.sh $DATA_DIR/variants/adsp/compact --max-parallel 5 --fork 15 --buffer-size 50000 --stats

# ====== load xdbr
runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/variants/adsp_wgs_pvcf_xdbr.json  --log-path $DATA_DIR/variants/logs/adsp-wgs-pvcf-xdbr.log --commit

# ===== set flags and load any missing variants
# test
# runpipe-plugin --plugin ADSPVCFLoader --xdbref "ADSP R5 58K WGS: SNVs and short INDELs|R5" --seqrepo-data-proxy $DATA_DIR/shared/seqrepo/2024-12-20 --log-path $DATA_DIR/variants/logs/adsp-vcf-flag-test.log --file $DATA_DIR/variants/adsp/compact/temp/gcad.qc.compact.r5.wgs.58506.GLnexus.2025.07.31.genotypes.chr21_23354996-46699980.ALL.vcf.gz --batch-size 10000

./$PROJECT_DIR/ad-genomicsdb-etl-pipeline/pipeline/variants/load_adsp_vcfs.sh $DATA_DIR/variants/adsp/compact/vcfs 25 commit

# SVS 
mkdir -p $DATA_DIR/variants/adsp/sv

# use s3_extract_vcf_fields to query s3 bucket and pipe smaller files to target directory

# run rep
$PROJECT_DIR/niagads-pylib/projects/variant-annotator/bin/run_vep_parallel.sh $DATA_DIR/variants/adsp/sv --max-parallel 5 --fork 15 --buffer-size 50000 --stats

# load vep

# test
# runpipe-plugin --plugin VEPAnnotationLoader --embedding-batch-size 512 --batch-size 50000 --log-path $DATA_DIR/variants/logs/vep-test.log --file $DATA_DIR/variants/adsp/compact/vep/gcad.qc.compact.r5.wgs.58506.GLnexus.2025.07.31.genotype.chrX_155701383-156030895.ALL.vcf.vep.json.gz --debug --verbose

$PROJECT_DIR/ad-genomicsdb-etl-pipeline/pipeline/variants/load_adsp_vep.sh $DATA_DIR/variants/adsp/compact/vep 25 commit
$PROJECT_DIR/ad-genomicsdb-etl-pipeline/pipeline/variants/load_adsp_vep.sh $DATA_DIR/variants/adsp/compact/vep/chr1N 5 64 force-cpu commit