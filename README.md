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

## Used packages

- http-conduit: for HTTL client
- regex-tdfa: regex matching
- aeson: JSON manipulation

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

## Example of output

Sample output.json file can look like:

```
[
  "<a href=\"http://auto.dir.bg/news.php?id=25035518\">Maybach ����� �� �������</a>",
  "<a href=\"http://banks.dir.bg/news.php?id=25031833\">������� ��������� �� ���������� �� ���� ���������� � �� ���� �������� ���...</a>",
  "<a href=\"http://banks.dir.bg/news.php?id=25027845\">��������� �� ������������ ����� ���� ���� �� ����� � �������� � �����������...</a>",
  "<a href=\"http://dnes.dir.bg/news/avtomobili-Germania-sasht-izbori-2016-25027779\">����� ������� � 35% ���� ���������� ����������� ����</a>",
  "<a href=\"http://banks.dir.bg/news.php?id=25027026\">������ ����� ������� ���������� ����������� ������ � �������� �� ������...</a>",
  "<a href=\"http://auto.dir.bg/news.php?id=25025497\">���������� �� 2017� ��������� � ��������� � Sofia Ring Mall</a>",
  "<a href=\"http://auto.dir.bg/news.php?id=24986849\">����� ���� ����� ���������</a>",
  "<a href=\"http://auto.dir.bg/news.php?id=24956205\">����� ���� ����� ������� �������� � ���</a>",
  "<a href=\"http://auto.dir.bg/news.php?id=24956168\">�������� ��������� <b>BMW</b> � ����� �������� (�����)</a>",
  "<a href=\"http://life.dir.bg/news.php?id=24953738\">����� ���� ����� ������� �������� � ���</a>"
]
```