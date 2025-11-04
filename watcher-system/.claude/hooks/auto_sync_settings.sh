#!/bin/bash
# Auto-sync settings hook
# Runs after tool use to sync settings if needed

# Check if settings file exists
SETTINGS_FILE="$HOME/.claude/settings.json"
BACKUP_DIR="$HOME/.claude/backups"

if [ ! -f "$SETTINGS_FILE" ]; then
    exit 0
fi

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Create a timestamped backup (limit to last 5 backups)
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/settings_backup_$TIMESTAMP.json"

# Only backup if settings changed (compare with latest backup)
LATEST_BACKUP=$(ls -t "$BACKUP_DIR"/settings_backup_*.json 2>/dev/null | head -1)
if [ -z "$LATEST_BACKUP" ] || ! cmp -s "$SETTINGS_FILE" "$LATEST_BACKUP"; then
    cp "$SETTINGS_FILE" "$BACKUP_FILE"

    # Keep only last 5 backups
    ls -t "$BACKUP_DIR"/settings_backup_*.json | tail -n +6 | xargs -r rm -f
fi

exit 0
