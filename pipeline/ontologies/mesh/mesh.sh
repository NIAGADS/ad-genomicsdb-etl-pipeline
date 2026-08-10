mesh2026.nt        - 
mesh2026.nt.sha1   - SHA-1 checksum of above file

# Combined, sorted, unique N-triple data.
wget -O $DATA_DIR/ontologies/mesh.nt.gz https://nlmpubs.nlm.nih.gov/projects/mesh/rdf/2026/mesh2026.nt
wget -O $DATA_DIR/ontologies/mesh.nt.sha1 https://nlmpubs.nlm.nih.gov/projects/mesh/rdf/2026/mesh2026.nt.sha1

sha1sum -c $DATA_DIR/ontologies/mesh.nt