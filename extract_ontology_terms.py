#!/usr/bin/env python3
"""
Extract term-CURIE pairs from NIAGADS dataset JSON files.

This script recursively searches through all JSON files in the niagads datasets
directory and extracts every term-CURIE pair, saving them to a tab-delimited file.
"""

import json
import sys
from pathlib import Path
from typing import Set, Tuple


def extract_term_curie_pairs(obj: object, pairs: Set[Tuple[str, str]]) -> None:
    """
    Recursively extract term-CURIE pairs from a JSON object.

    Extracts both complete (term, curie) pairs and term-only entries where
    curie is missing or empty.

    Args:
        obj: The JSON object to search (dict, list, or scalar)
        pairs: Set to accumulate extracted (term, curie) tuples
    """
    if isinstance(obj, dict):
        # Check if this dict has a 'term' key
        if 'term' in obj:
            term = obj.get('term')
            if isinstance(term, str) and term:  # Non-empty string
                # Include both complete pairs and term-only entries
                if 'curie' in obj:
                    curie = obj.get('curie')
                    if isinstance(curie, str) and curie:  # Non-empty curie
                        pairs.add((term, curie))
                else:
                    # Term without curie - add with empty string marker
                    pairs.add((term, ''))

        # Recursively search all values
        for value in obj.values():
            extract_term_curie_pairs(value, pairs)

    elif isinstance(obj, list):
        # Recursively search all items in the list
        for item in obj:
            extract_term_curie_pairs(item, pairs)


def main() -> None:
    """Main execution function."""
    niagads_dir = Path('/home/allenem/projects/genomicsdb/ad-genomicsdb-etl-pipeline/pipeline/datasets/niagads')

    if not niagads_dir.exists():
        print(f"Error: Directory {niagads_dir} does not exist", file=sys.stderr)
        sys.exit(1)

    all_pairs: Set[Tuple[str, str]] = set()

    # Find all JSON files in subdirectories
    json_files = list(niagads_dir.glob('*/*.json'))

    if not json_files:
        print(f"Warning: No JSON files found in {niagads_dir}", file=sys.stderr)
        sys.exit(1)

    print(f"Processing {len(json_files)} JSON files...", file=sys.stderr)

    for json_file in sorted(json_files):
        try:
            with open(json_file, 'r') as f:
                data = json.load(f)
                extract_term_curie_pairs(data, all_pairs)
        except (json.JSONDecodeError, IOError) as e:
            print(f"Warning: Error processing {json_file}: {e}", file=sys.stderr)

    # Sort pairs for consistent output
    sorted_pairs = sorted(all_pairs)

    # Write to output file
    output_file = niagads_dir / 'dataset-ontology-terms.txt'
    with open(output_file, 'w') as f:
        for term, curie in sorted_pairs:
            f.write(f"{term}\t{curie}\n")

    print(f"Extracted {len(sorted_pairs)} unique term-CURIE pairs", file=sys.stderr)
    print(f"Results saved to: {output_file}", file=sys.stderr)


if __name__ == '__main__':
    main()
