# Ontology annotation and verification

## Search and evaluate

Consult the current `TRACK_METADATA.md` for preferred ontologies by annotation category and `niagads.obo` for existing NIAGADS terms.

When available, use the NIAGADS MCP tool `searchOlsOntologies` (server: `https://api.niagads.org/api/mcp`) to search EBI-OLS. Search preferred ontologies first using relevant terminology, synonyms and conceptual alternatives. Evaluate alternative ontologies when preferred ontologies do not adequately represent the concept. Do not use `queryOntologyTerms` for this task; its semantic search endpoint is not implemented.

Retrieve individual ontology records to verify labels, CURIEs, definitions, synonyms and obsolescence status. Examine ontology hierarchies where relevant. Verify NIAGADS terms against their corresponding OBO entries.

Evaluate semantic fit in the context of the experiment. Previously used annotations are useful references but should not take precedence over more appropriate terms. Do not force poorly fitting mappings or invent ontology terms or CURIEs.

Titles and descriptions should accurately characterize the experiment in natural language. Ontology labels need not match manuscript, title or description terminology verbatim. Maintain exact correspondence between `study_diagnosis.phenotype` and the relevant `participant_phenotypes` term labels, as specified in the curation documentation.

## Present recommendations

Present the target metadata field, source concept, recommended ontology label and CURIE, rationale for the mapping, and a direct EBI-OLS term link for verification. For NIAGADS terms, reference the OBO file and corresponding term identifier.

Present meaningful alternatives when appropriate, including their verified labels, CURIEs, verification links and relative semantic fit.

## Fallback when ontology verification is unavailable

If `searchOlsOntologies` is unavailable or fails, use accessible OLS web/REST resources where possible. If ontology verification is still unavailable, explain the limitation and provide instructions for requesting administrator assistance where applicable.

For each unresolved annotation, provide the target metadata field, source concept and scientific context, preferred ontologies, suggested search phrases and a link to [EBI-OLS](https://www.ebi.ac.uk/ols4/). Ask the curator to provide the selected term and CURIE.

Distinguish curator-supplied mappings from independently verified mappings. Never present unverified mappings as verified. Continue unaffected curation activities while unresolved annotations remain pending.

If the NIAGADS ontology cannot be retrieved, request an upload of the current OBO file.

## Recommend new NIAGADS ontology terms

When available ontology terms do not adequately represent a concept, consider recommending an addition to the NIAGADS ontology. Explain why existing terms are unsuitable and provide:

- Proposed term label and definition.
- Suggested synonyms, where appropriate.
- Recommended `is_a` relationships to existing terms.
- Verified parent term labels, CURIEs and verification links.
- Scientific rationale for the proposed addition.

Ensure proposed `is_a` relationships represent genuine subclass relationships. Do not assign a CURIE to the proposed term or modify the ontology. Provide a complete proposed OBO term stanza for each recommended NIAGADS ontology addition, leaving the new term identifier unassigned.

## Curator interaction checkpoint

Allow the curator to discuss, refine and select ontology recommendations, investigate alternatives and consider proposed NIAGADS ontology additions.

Identify unresolved annotations and remain at this stage until the curator explicitly requests progression to metadata generation.
