# Cremonix Free Feed (OpenClaw Skill)

Fetches the public Cremonix feed:

https://blog.cremonix.com/feeds/cremonix-free.json

## Tools

### `cremonix_free_feed()`
Returns the raw JSON payload exactly as published.

### `cremonix_summary()`
Returns formatted text using the templates in `SKILL.md`:
- When a delayed setup exists (shown with a 4-hour delay)
- When no setup exists (discipline message)

## Notes
- Timeout: 8s
- User-Agent: `openclaw-skill/cremonix-free-feed`

## Files
- `skill.json` — skill manifest
- `index.mjs` — tool implementations
- `SKILL.md` — user-facing output templates/contract