# Pi Date Injector

A minimal Pi extension that injects the current date into every agent turn to prevent date-awareness errors.

## Usage

### Option 1: Load via command line
```bash
pi --extension ~/software/pi-date/index.ts
```

### Option 2: Add to user extensions
Add to `~/.pi/agent/settings.json`:
```json
{
  "resources": {
    "extensions": [
      "~/software/pi-date"
    ]
  }
}
```

### Option 3: Copy to extensions directory
```bash
cp ~/software/pi-date/index.ts ~/.pi/agent/extensions/
```

## How It Works

The extension uses the `before_agent_start` event to inject the current date into `systemPromptOptions.sections.addendum`. This is the preferred approach per Pi's extension documentation because:

- Pi appends it as a transcript delta (more efficient)
- Doesn't replace the entire system prompt
- Uses the dedicated `addendum` section for additional instructions

## Example Output

Every agent turn will see in its context:
```
The date is 10/13/2026, 20:00 BST.
```
