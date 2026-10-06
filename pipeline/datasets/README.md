# Dataset metadata conventions

These rules cover JSON metadata under `pipeline/datasets/`. The term tables reflect the current files as of 2026-10-05. They describe current assignments; they are not an independent validation of every ontology mapping. Blank placeholder terms are omitted from the tables.

The sections below identify preferred ontology sources for participant phenotypes, covariates, and data categories and list the terms and CURIEs currently used in the metadata. This list is not necessarily kept up to date.

## Study diagnosis

Each string in `study_diagnosis.phenotype` must exactly match an existing `term` under `participant_phenotypes` in the same file, including capitalization and spelling.

## Disease

Prefer DOID or MONDO for disease terms.

| Term | CURIE |
| --- | --- |
| Alzheimer's disease | `DOID:10652` |
| dementia | `DOID:1307` |
| mild cognitive impairment | `DOID:0080832` |
| Progressive supranuclear palsy | `Orphanet:683` |

## Neuropathology

Prefer the Human Phenotype Ontology (`HP`) for neuropathology terms. If not available, mappings from MONDO, DOID, or SYMP.  Alternatively, curate single or custom terms in the NIAGADS ontology as needed.

| Term | CURIE |
| --- | --- |
| amyloid-beta plaques | `NIAGADS:0000070` |
| Arteriolosclerosis | `MONDO:0006658` |
| Atherosclerosis | `HP:0002621` |
| Braak Stages | `NIAGADS:0000025` |
| CERAD score | `NIAGADS:0000026` |
| Cerebral amyloid angiopathy | `HP:0011970` |
| Hippocampal sclerosis | `HP:0033715` |
| LATE-NC | `UMLS:C5772801` |
| Lewy body | `HP:0100315` |
| vascular brain injury | `MONDO:0005621` |

## Ethnicity

Use the NCI Thesaurus (`NCIT`) for ethnicity terms.

| Term | CURIE |
| --- | --- |
| Hispanic or Latino | `NCIT:C17459` |
| Not Hispanic or Latino | `NCIT:C41222` |

## Race

Use the NCI Thesaurus (`NCIT`) for race terms.

| Term | CURIE |
| --- | --- |
| Asian | `NCIT:C41260` |
| Black or African American | `NCIT:C16352` |
| White | `NCIT:C48325` |

## Population

Use the Human Ancestry Ontology (`HANCESTRO`) for population and ancestry terms.

| Term | CURIE |
| --- | --- |
| African American | `HANCESTRO:0568` |
| East Asian | `HANCESTRO:0849` |
| European ancestry | `HANCESTRO:0005` |
| Hispanic or Latin | `HANCESTRO:0612` |
| Japanese | `HANCESTRO:0019` |
| Korean | `HANCESTRO:0022` |
| Latin or Admixed American ancestry | `HANCESTRO:0014` |

## Covariates

Prefer the NCI Thesaurus (`NCIT`) for age, sex, and gender covariates; more obscure covariates are defined as custom terms in the NIAGADS ontology.

| Term | CURIE |
| --- | --- |
| Age | `NCIT:C25150` |
| APOEε4 carrier status or allele number | `NIAGADS:0000061` |
| Gender | `NCIT:C17357` |
| Principal component analysis | `EDAM:operation_3960` |
| sequencing center | `NIAGADS:0000068` |
| Sex | `NCIT:C28421` |
| technical variables | `NIAGADS:0000069` |

## Data category

Use curated NIAGADS (`NIAGADS`) terms for data categories.

| Term | CURIE |
| --- | --- |
| aggregate variant association test summary statistics | `NIAGADS:0000072` |
| GWAS summary statistics | `NIAGADS:0000010` |
| single-variant association test summary statistics | `NIAGADS:0000067` |

## Gender

Use the NCI Thesaurus (`NCIT`) for participant gender terms.

| Term | CURIE |
| --- | --- |
| Female | `NCIT:C16576` |
| Male | `NCIT:C20197` |

## Clinical status

Prefer the Human Phenotype Ontology (`HP`) or Symptom Ontology (`SYMP`) for clinical status terms. Use curated NIAGADS (`NIAGADS`) terms where needed.

| Term | CURIE |
| --- | --- |
| Aggressive behavior | `HP:0000718` |
| Agitation | `HP:0000713` |
| Anxiety | `HP:0000739` |
| Apathy | `HP:0000741` |
| Cognitively Normal | Not assigned |
| Delusion | `HP:0000746` |
| Depression | `HP:0000716` |
| Disinhibition | `HP:0000734` |
| Dysphoria | `HP:0033838` |
| Emotional lability | `HP:0000712` |
| Hallucinations | `HP:0000738` |
| Indifference to social norms | `HP:5200124` |
| Irritability | `HP:0000737` |
| nighttime behavioral disturbance | `NIAGADS:0000071` |

## Derived phenotype

Use curated NIAGADS (`NIAGADS`) terms for derived phenotypes.

| Term | CURIE |
| --- | --- |
| combined resilience to Alzheimer’s disease neuropathology | `NIAGADS:0000065` |
| residual cognitive resilience to Alzheimer’s disease neuropathology | `NIAGADS:0000002` |

## Genotype

Use curated NIAGADS (`NIAGADS`) terms for genotype annotations.

| Term | CURIE |
| --- | --- |
| APOE ε4 carrier | `NIAGADS:0000059` |
| APOE ε4 non-carrier | `NIAGADS:0000060` |
