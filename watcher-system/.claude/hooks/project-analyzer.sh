#!/bin/bash
# Project analyzer hook - Analyzes project structure and dependencies
# Useful for understanding new projects or after major changes

set -e

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
ANALYSIS_DIR="$HOME/.claude/logs/analysis"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

mkdir -p "$ANALYSIS_DIR"

# Project analysis file
ANALYSIS_FILE="$ANALYSIS_DIR/project_analysis_${TIMESTAMP}.txt"

echo "🔍 Claude Code Project Analysis - $(date)" > "$ANALYSIS_FILE"
echo "=============================================" >> "$ANALYSIS_FILE"
echo "" >> "$ANALYSIS_FILE"

# Basic project info
echo "📁 Project Directory: $PROJECT_DIR" >> "$ANALYSIS_FILE"
echo "📊 Project Size: $(du -sh "$PROJECT_DIR" 2>/dev/null | cut -f1)" >> "$ANALYSIS_FILE"
echo "" >> "$ANALYSIS_FILE"

# Detect project type
echo "🏗️ Project Type Detection:" >> "$ANALYSIS_FILE"
if [ -f "$PROJECT_DIR/package.json" ]; then
    echo "  ✅ Node.js/JavaScript project detected" >> "$ANALYSIS_FILE"
    echo "  📦 Dependencies: $(jq -r '.dependencies // {} | keys | length' "$PROJECT_DIR/package.json" 2>/dev/null || echo "unknown")" >> "$ANALYSIS_FILE"
fi

if [ -f "$PROJECT_DIR/Cargo.toml" ]; then
    echo "  ✅ Rust project detected" >> "$ANALYSIS_FILE"
fi

if [ -f "$PROJECT_DIR/pom.xml" ] || [ -f "$PROJECT_DIR/build.gradle" ]; then
    echo "  ✅ Java project detected" >> "$ANALYSIS_FILE"
fi

if [ -f "$PROJECT_DIR/requirements.txt" ] || [ -f "$PROJECT_DIR/pyproject.toml" ]; then
    echo "  ✅ Python project detected" >> "$ANALYSIS_FILE"
fi

if find "$PROJECT_DIR" -name "*.cpp" -o -name "*.c" -o -name "*.h" | head -1 | grep -q .; then
    echo "  ✅ C/C++ project detected" >> "$ANALYSIS_FILE"
    echo "  📄 Source files: $(find "$PROJECT_DIR" -name "*.cpp" -o -name "*.c" | wc -l | tr -d ' ')" >> "$ANALYSIS_FILE"
    echo "  📄 Header files: $(find "$PROJECT_DIR" -name "*.h" -o -name "*.hpp" | wc -l | tr -d ' ')" >> "$ANALYSIS_FILE"
fi

echo "" >> "$ANALYSIS_FILE"

# Git info
if [ -d "$PROJECT_DIR/.git" ]; then
    echo "🔄 Git Information:" >> "$ANALYSIS_FILE"
    echo "  📍 Current branch: $(cd "$PROJECT_DIR" && git branch --show-current 2>/dev/null || echo "unknown")" >> "$ANALYSIS_FILE"
    echo "  📈 Total commits: $(cd "$PROJECT_DIR" && git rev-list --count HEAD 2>/dev/null || echo "unknown")" >> "$ANALYSIS_FILE"
    echo "  👤 Last author: $(cd "$PROJECT_DIR" && git log --format='%an' -1 2>/dev/null || echo "unknown")" >> "$ANALYSIS_FILE"
fi

echo "" >> "$ANALYSIS_FILE"

# File structure overview
echo "📂 Directory Structure (top-level):" >> "$ANALYSIS_FILE"
ls -la "$PROJECT_DIR" 2>/dev/null | head -20 >> "$ANALYSIS_FILE"

echo "" >> "$ANALYSIS_FILE"
echo "Analysis completed at: $(date)" >> "$ANALYSIS_FILE"

# Log the analysis
echo "📊 Project analysis saved: $ANALYSIS_FILE" >> ~/.claude/logs/session.log

# Keep only last 10 analysis files
ls -t "$ANALYSIS_DIR"/project_analysis_*.txt 2>/dev/null | tail -n +11 | xargs rm -f 2>/dev/null || true