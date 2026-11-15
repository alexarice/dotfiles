---
name: elm-websearch
description: Search the public web with the ELM web-search tool for current, unfamiliar, or citation-backed information. Use for recent facts, news, changing technical documentation, verification, recommendations, and requests for sources or links.
---

# ELM web search

Use the `elm-websearch` tool when answering requires current public-web information or verifiable sources.

## Search

1. **Write a focused query.** Split unrelated questions into separate searches.
2. **Use `standard` depth by default.** Use `fast` for a short, keyword-shaped lookup and `deep` only for complex, multi-step research.
3. **Start with the default of 10 results** and request more only when needed.
4. **Use domain filters** when authoritative or primary sources are known. Use date filters for time-bounded questions.
5. **Refine the query or search again** when results are weak, contradictory, or incomplete.

Example:

```json
{
  "query": "latest Spring Boot release",
  "depth": "standard",
  "max_results": 10
}
```

The tool returns raw `searchResults`; evaluate and synthesize the evidence rather than copying it uncritically.

## Answer from results

- **Prefer primary and authoritative sources.**
- **Support factual claims with links** to result URLs.
- **Distinguish publication dates** from the dates events occurred.
- **Compare multiple reliable sources** when accuracy or recency matters.
- **State uncertainty** when the returned evidence does not settle a claim.
- **Never invent citations** or overstate what a result supports.
- **Do not search** when the user explicitly asks not to browse.
