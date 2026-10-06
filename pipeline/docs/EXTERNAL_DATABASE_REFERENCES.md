# External Database References

## database_type_ids

Qualify the type of data we pull from a data resource.  
As an example, even though NIAGADS-DSS stores a variety of genomic data, we only pull genetic variant analysis results.  

| Term ID | Term | Example DB |
| --- | --- | --- |
| `EDAM:data_3498` | Sequence variations | dbSNP |
| `EDAM:data_0916` | Gene report | Ensembl Gene Annotation |
| `EDAM:data_0582` | Ontology | Gene Ontology (GO) |
| `EDAM:operation_3672` | Gene functional annotation | PAN-GO |
| `EDAM:operation_3197` | Genetic variation analysis | NIAGADS-DSS |
| `EDAM:data_0896` | Protein report | UniProtKB |
| `EDAM:data_0918` | DNA variation | ADSP R5 58K WGS |
