# Schema and reference resources

## Fetch at session start

| Resource | Explicit branch and path |
|---|---|
| TrackRecord JSON Schema | [open-access-service/main/generated-resources/schemas/common/track/models/track_record.schema.json](https://github.com/NIAGADS/open-access-service/blob/main/generated-resources/schemas/common/track/models/track_record.schema.json) |
| Annotation conventions | [ad-genomicsdb-etl-pipeline/release/3.0/pipeline/docs/TRACK_METADATA.md](https://github.com/NIAGADS/ad-genomicsdb-etl-pipeline/blob/release/3.0/pipeline/docs/TRACK_METADATA.md) |
| Reference records | [ad-genomicsdb-etl-pipeline/release/3.0/pipeline/tracks/NIAGADS](https://github.com/NIAGADS/ad-genomicsdb-etl-pipeline/tree/release/3.0/pipeline/tracks/NIAGADS) |
| NIAGADS ontology | [niagads-ontology/main/obo/niagads.obo](https://github.com/NIAGADS/niagads-ontology/blob/main/obo/niagads.obo) |

Retrieve actual resource contents using GitHub or accessible public URLs. Use the specified branches and record the resolved commit SHA when available. Use consistent resource versions throughout a curation session.

If the schema is unavailable or incomplete, request an upload of the current JSON Schema before generating or validating metadata. If the curation documentation or NIAGADS ontology is unavailable, request the current file. If reference metadata cannot be accessed, request examples as needed. Continue unaffected curation work.

## Reference selection

Inspect `pipeline/tracks/NIAGADS/<accession>/metadata/` recursively, including nested analysis directories. Metadata outside `in-queue` are finalized reference records.

- Include records with `track_type` annotations for GWAS summary statistics (`NIAGADS:0000010`) or single-variant association test summary statistics (`NIAGADS:0000067`), including meta-analyses. These CURIEs identify track types, not dataset accessions.
- Exclude `in-queue`, validation reports, non-metadata files, gene-risk, variant aggregation and structural-variant analyses. Retain eligible single-variant analyses of rare variants.
- When benchmarking, exclude the held-out target metadata from references.

## Non-FILER schema handling

Discover `is_filer_annotation: true` from property definitions dynamically, including nested definitions and local references. For non-FILER data these fields are not required, but allowed. Do not strip supplied valid values or solicit absent FILER-only metadata.
