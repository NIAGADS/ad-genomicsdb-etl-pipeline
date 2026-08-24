mesh2026.nt        - 
mesh2026.nt.sha1   - SHA-1 checksum of above file

# Combined, sorted, unique N-triple data.
wget -O $DATA_DIR/ontologies/mesh.nt https://nlmpubs.nlm.nih.gov/projects/mesh/rdf/2026/mesh2026.nt
wget -O $DATA_DIR/ontologies/mesh.nt.sha1 https://nlmpubs.nlm.nih.gov/projects/mesh/rdf/2026/mesh2026.nt.sha1

sha1sum -c $DATA_DIR/ontologies/mesh.nt

# load external database reference

runpipe-plugin --plugin ExternalDatabaseLoader --file $CONFIG_DIR/ontologies/mesh/mesh_xdbr.json  --log-path $DATA_DIR/ontologies/mesh-xdbr.log --commit

# load ontology

runpipe-plugin --plugin MeSHDescriptorLoader --xdbref "Medical Subject Headings|2026" --file $DATA_DIR/ontologies/mesh.nt --batch-size 1000 --embedding-batch-size 128 --log-path $DATA_DIR/ontologies/mesh-load.log --commit
