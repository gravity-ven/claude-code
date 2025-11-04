# Aia Quick Start Guide

## What is Aia?

Aia is your personal JARVIS-like AI assistant that:
- **Logs every interaction** with Claude Code
- **Learns your preferences** and work patterns
- **Remembers context** across sessions
- **Provides intelligent briefings** to Claude Code
- **Works silently** in the background, always active

## Installation Complete!

Aia is now installed and **automatically active** on every Claude Code session. No manual activation needed!

## Quick Commands

```bash
# Show current status and recent work
aia

# Check if Aia is running
aia status

# View detailed statistics
aia stats

# Search your interaction history
aia search "authentication"

# Show recent work (last 7 days)
aia recent

# Show learned preferences
aia preferences

# Show learned patterns
aia patterns

# Export all data
aia export backup.json

# Get help
aia help
```

## How Aia Helps Claude Code

Every time you interact with Claude Code, Aia:

1. **Logs the interaction** - Captures your input, Claude's response, tools used, files modified
2. **Learns from it** - Updates your personality profile and behavioral patterns
3. **Provides context** - Briefs Claude Code about your preferences and recent work
4. **Remembers everything** - Maintains searchable history across all sessions

## Example Workflow

### Morning Session
```bash
# You start Claude Code
→ Aia activates automatically
→ Shows: "🤖 Aia: Active & Learning"
→ Silently briefs Claude about yesterday's work
```

### Working on a Project
```
You: "Let's continue with the authentication feature"
→ Aia recalls last session's auth work
→ Provides Claude with full context
→ Claude knows exactly where you left off
```

### Checking Your Patterns
```bash
aia preferences
# Shows:
# - Communication Style: Technical
# - Preferred Tech: TypeScript, React, Python
# - Common Tasks: Feature Development, Debugging
# - Work Pattern: Peak activity around 14:00
```

## What Aia Learns

### Automatically Learned
- Your communication style (formal, casual, technical)
- Preferred technologies and tools
- Common workflows and task sequences
- Work hours and productivity patterns
- Decision-making preferences
- File and project associations

### Continuously Improving
The more you use Claude Code, the smarter Aia becomes at:
- Predicting what you need
- Providing relevant context
- Suggesting optimizations
- Preventing common errors

## Privacy & Data

- **All data stored locally** in `~/.claude/aia-data/`
- **No external transmission** - your data never leaves your machine
- **Full control** - export, delete, or reset anytime
- **Transparent** - all databases are SQLite (readable)

## Data Locations

```
~/.claude/aia-data/
├── aia_core.py          # Core intelligence engine
├── aia_logger.py        # Interaction logger
├── aia                  # CLI tool
├── interactions.db      # All interactions (SQLite)
├── projects.db          # Project contexts (SQLite)
├── personality.json     # Your learned profile
├── patterns.json        # Learned patterns
└── aia.log             # Activity log
```

## Troubleshooting

### Aia not showing up
```bash
# Check status
aia status

# Verify hook is installed
cat ~/.claude/settings.json | grep aia_activation

# Check logs
cat ~/.claude/aia-data/aia.log
```

### Database issues
```bash
# Check database integrity
sqlite3 ~/.claude/aia-data/interactions.db "PRAGMA integrity_check;"
```

### Reset everything
```bash
# This clears all learned data
aia reset
```

## Advanced Usage

### Search for specific topics
```bash
aia search "API design"
aia search "TypeScript error"
aia search "deployment"
```

### View project-specific context
```bash
# From within a project directory
aia project .
```

### Export data for backup
```bash
aia export ~/backups/aia-backup-2024.json
```

### Cleanup old data (keep last 90 days)
```bash
aia cleanup 90
```

## Integration with Your Workflow

Aia integrates seamlessly:

1. **Session Startup Hook** - Activates on Claude Code start
2. **User Prompt Hook** - Activates before each interaction
3. **Silent Operation** - Works in background, minimal output
4. **Context Enhancement** - Enriches Claude's understanding

## What Makes Aia Special

Unlike simple logging tools, Aia:
- **Understands context** - Not just logs, but learns
- **Provides intelligence** - Analyzes patterns and preferences
- **Enhances Claude** - Makes Claude Code aware of your history
- **Anticipates needs** - Predicts what you might need next
- **Improves over time** - Gets smarter with every interaction

## Next Steps

1. **Just use Claude Code normally** - Aia learns passively
2. **Check stats occasionally** - `aia stats` to see what's learned
3. **Search when needed** - `aia search "topic"` to recall past work
4. **Review preferences** - `aia preferences` to see your profile

## Philosophy

Aia embodies the JARVIS philosophy:
- **Silent but aware** - Works quietly in the background
- **Learns continuously** - Never stops improving
- **Context-aware** - Always knows what matters
- **Anticipatory** - Predicts needs before being asked
- **Privacy-first** - Your data stays yours

---

## Quick Reference Card

```
┌─────────────────────────────────────────────────────┐
│                  Aia Quick Reference                 │
├─────────────────────────────────────────────────────┤
│ aia              → Show briefing & recent work       │
│ aia status       → Check Aia status                 │
│ aia stats        → Detailed statistics              │
│ aia search <q>   → Search history                   │
│ aia recent [d]   → Recent work (default 7 days)     │
│ aia preferences  → Show learned preferences         │
│ aia patterns     → Show learned patterns            │
│ aia export [f]   → Export data                      │
│ aia cleanup [d]  → Delete old data (default 90d)    │
│ aia reset        → Reset personality profile        │
│ aia help         → Show help                        │
├─────────────────────────────────────────────────────┤
│ Status: 🤖 Active & Learning                        │
│ Data: ~/.claude/aia-data/                           │
│ Version: 1.0.0                                       │
└─────────────────────────────────────────────────────┘
```

---

**You're all set!** Aia is now your personal intelligence assistant, working 24/7 to make Claude Code smarter about your needs.

*Welcome to the future of AI-assisted development.*
