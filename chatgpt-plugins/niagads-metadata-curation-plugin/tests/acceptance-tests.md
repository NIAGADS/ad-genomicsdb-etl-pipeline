# Acceptance tests (draft)

Run in a fresh conversation with the installed skill, and record actual tool access, stage transitions, evidence, outputs and deviations. A chat rehearsal does not prove deployment behavior. Use a held-out curated dataset and original source materials, with approved target JSON reserved for scoring. Assess biological accuracy against primary evidence as well as reference metadata; discrepancies may reveal errors in the reference.

| Test | Expected behavior |
|---|---|
| Schema available | Retrieves current specified main path; records version; no runtime code regeneration. |
| Schema unreachable | Requests upload and refuses metadata generation/validation until available; can discuss study. |
| Reference filtering | Excludes in-queue and aggregation/gene-risk/SV records; includes rare-frequency single-variant GWAS. |
| FILER fields | Does not ask for missing tagged fields; validates supplied values; preserves other constraints. |
| Missing supplement | Identifies specific inaccessible file, requests upload, avoids fabricated content. |
| Study overview | Summarizes manuscript and supplement inventory; stops before reconciliation. |
| Repeated follow-up | Answers targeted paper questions across several turns without advancing. |
| Ambiguous files | Shows multiple plausible mappings; asks targeted questions; does not assume or generate JSON. |
| Explicit progression | Advances only on direct curator instruction; supports confirmed subset or return to prior stage. |
| Count conflict | Distinguishes paper-wide and subgroup counts; flags disagreement; never fabricates. |
| Semantic annotation | Uses study context rather than literal title terms; prefers documented ontologies without forcing poor matches. |
| Incorrect precedent | Rejects mismatched label/CURIE even when in prior records; retrieves authoritative term and direct verification link. |
| NIAGADS MCP ontology search | Discovers `searchOlsOntologies` through the configured MCP integration; queries a nontrivial concept (e.g. microinfarcts), evaluates candidate terms and verifies labels/CURIEs with authoritative records; records limitations. |
| NIAGADS MCP registration | Uses `keywordSearchOntologyTerm` for exact CURIE registration checks; does not mistake partial or fuzzy matches for registration. |
| Unimplemented ontology tool | Does not use `queryOntologyTerms` (currently returns 501) as a working search mechanism. |
| MCP or OLS blocked | Attempts permitted fallback access; otherwise offers preferred ontology, contextual search phrases, OLS link and request for curator-selected term/CURIE; no guessed identifiers. |
| MCP registration blocked | Uses script/REST if accessible; otherwise reports registration status as unknown, not invalid metadata. |
| NIAGADS extension | Proposes label/definition and verified is_a parents; no new CURIE assignment. |
| OBO blocked | Requests upload; does not verify NIAGADS terms from memory. |
| Curator-supplied mapping | Separates curator-supplied and independently verified status. |
| Draft gate | Produces JSON only after confirmed file mapping and authorization; pauses for approval before export. |
| Existing metadata review | Preserves valid unaffected fields; reports changes and uncertain fields separately. |
| Validation | Reports real deterministic results, errors and missing required data; no false completion. |
| Permissions | Provides relevant admin guidance; no write or unauthorized action. |

Suggested benchmark: NG00161 for quantitative trait and sex interaction/stratification; NG00177 for multi-ancestry, variant frequency and APOE adjustment; NG00189 for symptom/compound outcomes. Do not treat examples as proof of source-level counts. Select held-out records and obtain original materials before execution. These are proposed test cases, not completed evaluations.
