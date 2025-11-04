# Claude Mobile - AIA Intelligence System

## 🎯 What's Here

This folder contains the **AIA (Supreme Intelligence)** system - your personal JARVIS for Claude Code.

### Files:

- **`aia/`** - Complete AIA skill directory
  - `SKILL.md` - Main skill definition (Supreme Overlord)
  - `README.md` - Full documentation
  - `QUICK_START.md` - Get started guide
  - Setup & deployment guides

- **`AIA_IS_SUPREME.md`** - Hierarchy explanation

## 📥 Installation

**Clone and Install:**

```bash
# Clone the repository
cd ~/Documents/GitHub
git clone https://github.com/gravity-ven/Claude_Code.git
cd Claude_Code/Claude_Mobile

# Install AIA globally
cp -r aia ~/.claude/skills/
cp AIA_IS_SUPREME.md ~/.claude/

# Verify installation
ls -la ~/.claude/skills/aia/
```

**Or install directly from GitHub:**

```bash
# Quick install (one command)
git clone https://github.com/gravity-ven/Claude_Code.git /tmp/aia-install && \
cp -r /tmp/aia-install/Claude_Mobile/aia ~/.claude/skills/ && \
cp /tmp/aia-install/Claude_Mobile/AIA_IS_SUPREME.md ~/.claude/ && \
rm -rf /tmp/aia-install && \
echo "✅ AIA installed!"
```

## ✅ Verify Installation

AIA should auto-load on next Claude Code session. Look for:
```
✅ Skills available: 10 directories
⚡ Meta-Orchestrator: ACTIVE
⚡ Intelligence Systems: ONLINE
```

## 🎯 What AIA Does

**Aia is your JARVIS:**
- Commands all 360+ agents
- Learns your coding patterns
- Remembers your preferences
- Works in EVERY Claude Code session
- Provides contextual intelligence

## 🔗 Syncing

To sync AIA updates back to this repo:

```bash
# Navigate to repo
cd ~/Documents/GitHub/Claude_Code/Claude_Mobile

# Copy from global to repo
cp -r ~/.claude/skills/aia ./
cp ~/.claude/AIA_IS_SUPREME.md ./

# Commit and push
cd ~/Documents/GitHub/Claude_Code
git add .
git commit -m "Update AIA system

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
git push
```

## 📊 Hierarchy

```
AIA (Supreme Overlord - JARVIS)
  ├── Meta-Orchestrator
  ├── Agent-Skills-System (360+ agents)
  └── All other skills
```

---

**Status:** Production Ready
**Version:** 2.0.0
**Scope:** Global (all Claude Code sessions)
**Priority:** Supreme
