# hs-task2

Test Haskell task implementing simple HTTP client tool.
Done for 4 days.

## Task

- Make a <SOME-SITE> text search query
- Return URLs of top 10 results in JSON file
- Search query and output file name are given as command-line arguments

## Implementation

Library exposes public functions for retrieving top URLs from the site.
Main module use it (`topLinks`) to get them via URL query (`searchUrl`).
`searchUrl` gets string and convert it to query search URL. Main select
10 URLs only (TOP-10), encodes them into JSON (with aeson package) and
writes into output file.

Output file is encoded in UTF-8. To test JSON Python can be used:

```
import json
d = json.loads(open('output.json', 'r', encoding='utf-8').read())
print(d[0], len(d))
```

## Usage

```
stack exec task2-exe -- -q "query string" --output=some-file.json
```
Options syntax:

```
SYNTAX: task2 [options...]
  -h, -?   --help         print this help
  -q STR   --query=STR    query string
  -o FILE  --output=FILE  output file (default: output.json)
```
