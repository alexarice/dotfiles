---
name: web-search
description: "Search the web using ddgr (DuckDuckGo CLI). Use when you need current information not in your training data: recent news, documentation, APIs, libraries, or facts."
---

## Web Search with ddgr

```bash
ddgr --noua --json --np -n 5 "search query"
```

- `--noua` → disable User-Agent rotation (avoids HTTP 202 errors)
- `--json` → structured output
- `--np` → no prompt, exit immediately
- `-n 5` → limit results (0-25)

That's all you need. Use it when you need to look something up on the web.
