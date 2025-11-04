#!/bin/bash
# Auto-backup script for important file changes
# Triggered by hook system

set -e

BACKUP_DIR="$HOME/.claude/backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Function to backup a file
backup_file() {
    local file="$1"
    if [ -f "$file" ]; then
        local backup_name="${file//\//_}_${TIMESTAMP}"
        cp "$file" "$BACKUP_DIR/$backup_name"
        echo "🔄 Backed up: $file -> $backup_name" >> ~/.claude/logs/backup.log
    fi
}

# Backup critical files
if [ -f "$PROJECT_DIR/package.json" ]; then
    backup_file "$PROJECT_DIR/package.json"
fi

if [ -f "$PROJECT_DIR/CLAUDE.md" ]; then
    backup_file "$PROJECT_DIR/CLAUDE.md"
fi

# Backup any modified .cpp or .c files in the last 5 minutes
find "$PROJECT_DIR" -name "*.cpp" -o -name "*.c" -o -name "*.h" | while read -r file; do
    if [ -f "$file" ] && [ $(stat -f "%m" "$file" 2>/dev/null || stat -c "%Y" "$file" 2>/dev/null || echo 0) -gt $(($(date +%s) - 300)) ]; then
        backup_file "$file"
    fi
done

# Clean old backups (keep last 50)
ls -t "$BACKUP_DIR" | tail -n +51 | xargs -I {} rm -f "$BACKUP_DIR/{}" 2>/dev/null || true

echo "✅ Auto-backup completed: $(date)" >> ~/.claude/logs/backup.log