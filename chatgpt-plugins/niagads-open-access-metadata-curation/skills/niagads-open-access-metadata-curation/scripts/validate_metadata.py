import argparse
import json
from pathlib import Path

from jsonschema.validators import validator_for


def validate_metadata(schema_path: Path, metadata_paths: list[Path]) -> dict:
    schema = json.loads(schema_path.read_text(encoding="utf-8"))
    validator_class = validator_for(schema)
    validator_class.check_schema(schema)
    validator = validator_class(schema)
    results = {}
    for path in metadata_paths:
        metadata = json.loads(path.read_text(encoding="utf-8"))
        errors = [
            {"path": error.json_path, "message": error.message}
            for error in validator.iter_errors(metadata)
        ]
        results[str(path)] = {"valid": not errors, "errors": errors}
    return results


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Validate metadata against the current JSON Schema."
    )
    parser.add_argument("schema", type=Path)
    parser.add_argument("metadata", type=Path, nargs="+")
    args = parser.parse_args()
    results = validate_metadata(args.schema, args.metadata)
    print(json.dumps(results, indent=2))
    raise SystemExit(0 if all(result["valid"] for result in results.values()) else 1)
