# Pi Builtin

Collection of built-in Pi extensions that enhance default behavior.

## Extensions

### prefer-builtin-tools

Instructs Pi to prefer builtin tools (`read`, `edit`) over shell commands for file operations.

**Why:** Using Pi's builtin tools provides:
- Better error handling
- Automatic file mutation queuing
- Safer edits with exact text matching
- Cleaner transcript history

**Usage:** Automatically loaded via package configuration.

**Before:**
```bash
# Using shell commands
sed -i 's/old/new' file.txt
cat file.txt | head -20
```

**After:**
```typescript
// Using builtin tools
await tools.edit({ path: "file.txt", edits: [...] });
await tools.read({ path: "file.txt", limit: 20 });
```

## Installation

Add to `~/.pi/agent/settings.json`:

```json
{
  "packages": [
    "~/software/pi-builtin"
  ]
}
```

Or load individual extensions:

```json
{
  "extensions": [
    "~/software/pi-builtin/prefer-builtin-tools.ts"
  ]
}
```

## Development

```bash
# Test with Pi
pi --extension ~/software/pi-builtin/prefer-builtin-tools.ts
```

## License

MIT
