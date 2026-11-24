"""Report registration of ontology CURIEs in the NIAGADS database."""
import argparse
import json
from pathlib import Path
from urllib.parse import urlencode
from urllib.request import urlopen

API_URL = "https://api.niagads.org/api/service/ontology-lookup"


def collect_terms(value, terms):
    if isinstance(value, dict):
        curie = value.get("curie")
        label = value.get("term")
        if isinstance(curie, str) and curie.strip() and isinstance(label, str):
            terms.setdefault(curie, set()).add(label)
        for child in value.values():
            collect_terms(child, terms)
    elif isinstance(value, list):
        for child in value:
            collect_terms(child, terms)


def registration_status(payload, curie):
    rows = payload["data"]
    return (
        "registered"
        if rows and rows[0]["id"] == curie
        else "not_registered"
    )


def lookup(curie, timeout=15):
    url = API_URL + "?" + urlencode({"content": "summary", "keyword": curie})
    try:
        with urlopen(url, timeout=timeout) as response:
            payload = json.load(response)
        return {"status": registration_status(payload, curie), "lookup_url": url}
    except Exception as exc:
        return {"status": "unknown", "lookup_url": url, "error": str(exc)}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("metadata", type=Path, nargs="+")
    args = parser.parse_args()
    terms = {}
    for path in args.metadata:
        collect_terms(json.loads(path.read_text(encoding="utf-8")), terms)
    results = [dict(curie=curie, terms=sorted(labels), **lookup(curie))
               for curie, labels in sorted(terms.items())]
    print(json.dumps(results, indent=2))


if __name__ == "__main__":
    main()
