# NIAGADS Open Access Metadata Curation

A ChatGPT skill for interactive curation and validation of metadata for NIAGADS open-access genomic datasets.

The skill guides curators through manuscript and supplementary material review, experimental design characterization, ontology annotation, metadata generation and validation, following NIAGADS metadata standards.

## Supported data types

The current implementation supports NIAGADS-hosted genome-wide association study (GWAS) summary statistics, single-variant association tests and meta-analyses.

## Installation

1. Open **Plugins** in the ChatGPT sidebar.
2. Search for **NIAGADS Open Access Metadata Curation** in the Plugin Directory.
3. Select the plugin and click **Install**.

See [Plugins in ChatGPT](https://help.openai.com/en/articles/20001256-plugins-in-chatgpt) for additional information.

### Ontology lookup

The skill uses ontology tools provided by the NIAGADS Open Access MCP server at `https://api.niagads.org/api/mcp`. These tools search EBI-OLS for ontology annotations and check whether terms are registered in the NIAGADS database. They are available when the NIAGADS MCP integration is enabled in the plugin. No separate EBI-OLS MCP connection is required.

## Getting started

Start a new conversation using the NIAGADS Open Access Metadata Curation skill. The skill will prompt you for the information and source materials needed to begin curation.  These include the associated publication (DOI or PUBMED ID) associated with the dataset to be curated and the NIAGADS accession number, as well as the README and data dictionary submitted to NIAGADS.

The skill guides you through the following stages:

1. Study review
2. Experimental design characterization and file-to-analysis mapping
3. Ontology annotation
4. Metadata generation and refinement
5. Validation and export

The workflow is interactive, allowing curators to ask questions, review findings and revise annotations before proceeding.

## Outputs

- Individual JSON metadata files for each annotated data file.
- JSON Schema validation results.
- Ontology annotation references and verification links.
- Inventory of ontology terms requiring registration in the NIAGADS database before metadata ingestion.
- Proposed additions to the NIAGADS ontology in OBO format, where applicable.

## Troubleshooting

If source materials  cannot be retrieved, the skill will request copies. If automated ontology lookup is unavailable, the skill will guide curators through manual term identification using EBI-OLS.

For EDU users, contact your ChatGPT workspace administrator if skill installation or external service connections are restricted.

## Extending supported data types

When extending the skill to support additional track types, review and update the following files:

- `SKILL.md`: Supported track types and workflow scope.
- `references/resources.md`: Reference metadata selection and eligibility criteria.
- `references/experimental-design.md`: Track-specific experimental design characterization and file-to-analysis mapping.
- `tests/acceptance-tests.md`: Acceptance criteria for newly supported track types.

The acceptance tests are intended for development and quality assurance and are not required in the distributed plugin package.
