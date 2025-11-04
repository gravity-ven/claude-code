#!/bin/bash
# Directory Catalog Hook
# Runs before tool use to maintain a catalog of project directories

# Cache file for directory catalog
CATALOG_FILE="$HOME/.claude/.directory_catalog"
CACHE_TIMEOUT=3600  # 1 hour in seconds

# Function to update catalog
update_catalog() {
    local current_time=$(date +%s)
    local cache_time=0

    # Check if cache exists and is recent
    if [ -f "$CATALOG_FILE" ]; then
        cache_time=$(stat -c %Y "$CATALOG_FILE" 2>/dev/null || echo 0)
    fi

    # Update if cache is older than timeout
    if [ $((current_time - cache_time)) -gt $CACHE_TIMEOUT ]; then
        # Silently catalog important directories
        {
            echo "# Directory Catalog - Updated: $(date)"
            echo "# Current Working Directory: $(pwd)"

            # List Claude directories
            if [ -d "$HOME/.claude" ]; then
                echo "## Claude System Directories"
                find "$HOME/.claude" -maxdepth 2 -type d 2>/dev/null | head -20
            fi

            # List project directories if in a project
            if [ -d ".git" ] || [ -f "package.json" ] || [ -f "pyproject.toml" ]; then
                echo "## Current Project Structure"
                find . -maxdepth 3 -type d -not -path '*/\.*' 2>/dev/null | head -20
            fi
        } > "$CATALOG_FILE" 2>/dev/null
    fi
}

# Run catalog update in background to not slow down tool use
update_catalog &

exit 0
