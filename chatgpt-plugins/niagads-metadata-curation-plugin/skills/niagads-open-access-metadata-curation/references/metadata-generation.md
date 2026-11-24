# Metadata generation, refinement and export

## Metadata generation

Generate draft metadata after the curator has confirmed the file-to-analysis mappings and authorized progression from ontology annotation.

Use the current JSON Schema, curation documentation and finalized reference metadata to guide content, terminology and formatting. Examine relevant reference metadata to identify established language patterns and templates for titles (`name`) and descriptions. Follow these conventions where appropriate, adapting the language to the specific experimental design. Maintain consistency across related analyses while distinguishing file-specific experimental characteristics.

Populate identifiers, filenames, checksums, file sizes, genome builds, release information and curation history from supplied or verified information. Preserve existing values when refining metadata unless a correction is warranted. Do not invent missing values or processing events.

Identify relevant optional fields that have not been populated and explain what information they could capture. Allow the curator to choose whether to omit these fields or investigate further through discussion and consultation of source materials. Apply the non-FILER handling instructions in `resources.md`. Request curator input for missing required information. Identify unresolved annotations and conflicting evidence separately from the metadata JSON.

## Curator review and refinement

Present draft metadata for curator review. Provide supporting source references and ontology verification links separately from the JSON.

When annotating multiple related files, summarize shared metadata once and highlight file-specific differences to facilitate review.

Allow the curator to ask questions, request revisions and revisit earlier curation stages. Obtain explicit curator approval before proceeding to final validation and export.

## Validation and export

Validate each metadata record against the current JSON Schema, applying the non-FILER handling instructions in `resources.md` and the annotation requirements in `TRACK_METADATA.md`.

Report validation errors with their corresponding field paths and work with the curator to resolve them. If validation cannot be performed, communicate this limitation.

Provide a separate downloadable JSON file for each annotated data file. Report any remaining unresolved curation issues separately. Metadata that fails validation or lacks required information must be identified as incomplete rather than finalized.

## Final ontology report

At export, extract and deduplicate ontology CURIEs across the metadata records. Use the NIAGADS MCP tool `keywordSearchOntologyTerm` to check database registration of each unique CURIE when available. Confirm an exact CURIE match in the returned identifier; partial or fuzzy matches do not establish registration. If the MCP tool is unavailable, use `scripts/check_ontology_registration.py` or the REST endpoint (`https://api.niagads.org/api/service/ontology-lookup?content=summary&keyword=<curie>`) when network access permits. Report unavailable lookups as unknown. [API specification](https://api.niagads.org/api/openapi).

Report registered terms, terms requiring database loading before metadata ingestion, proposed NIAGADS ontology additions with their full proposed OBO stanzas, and terms whose registration status could not be determined. Database registration is a pre-load readiness check, not a metadata validation requirement.
