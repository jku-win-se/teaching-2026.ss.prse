# Task: Generate PNG diagrams from PlantUML sources via Kroki API

Working directory: `C:\Users\lucab\projects\SE-Praktikum-2026\teaching-2026.ss.prse`

## What to do

1. Read ALL `.puml` files from `tools\diagrams\`
2. For each `.puml` file, generate a PNG via the Kroki API
3. Save the PNG next to the `.puml` file with the same name but `.png` extension
4. Print a summary of all generated files with sizes

## How to call Kroki

Use a GET request with the diagram source compressed and base64url-encoded in the URL:

```python
import zlib, base64, urllib.request

def generate_png(puml_source, output_path):
    compressed = zlib.compress(puml_source.encode("utf-8"), 9)
    encoded = base64.urlsafe_b64encode(compressed).decode("ascii")
    url = f"https://kroki.io/plantuml/png/{encoded}"
    req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
    with urllib.request.urlopen(req, timeout=30) as resp:
        with open(output_path, "wb") as f:
            f.write(resp.read())
```

## Expected files to generate

From `tools\diagrams\`:
- 01-start-feature.puml -> 01-start-feature.png
- 01-start-feature-simple.puml -> 01-start-feature-simple.png
- 02-save-progress.puml -> 02-save-progress.png
- 02-save-progress-simple.puml -> 02-save-progress-simple.png
- 03-submit-for-review.puml -> 03-submit-for-review.png
- 03-submit-for-review-simple.puml -> 03-submit-for-review-simple.png
- 04-merge-cleanup.puml -> 04-merge-cleanup.png
- 04-merge-cleanup-simple.puml -> 04-merge-cleanup-simple.png
- 05-create-release-tag.puml -> 05-create-release-tag.png
- 05-create-release-tag-simple.puml -> 05-create-release-tag-simple.png
- 06-full-workflow.puml -> 06-full-workflow.png
- 06-full-workflow-simple.puml -> 06-full-workflow-simple.png

Total: 12 PNG files.

## Completion

Print a list of all generated PNG files with their file sizes.
If any file fails, log the error and continue with the next one.
