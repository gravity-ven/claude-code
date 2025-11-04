#!/bin/bash
################################################################################
# Push AIA System to GitHub
################################################################################

echo "🚀 Pushing AIA Supreme Intelligence to GitHub..."
echo ""
echo "Repository: https://github.com/SpartanLabs-ai/Claude_Code"
echo ""

cd "$(dirname "$0")"

# Show current status
echo "📊 Current Status:"
git log --oneline | head -5
echo ""

# Show files to be pushed
echo "📦 Files to push:"
git diff --stat origin/master 2>/dev/null || echo "  - 31 files (new repository)"
echo ""

# Instructions
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⚠️  Authentication Required"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Please run ONE of these commands:"
echo ""
echo "Option 1: SSH (Recommended)"
echo "  git remote set-url origin git@github.com:SpartanLabs-ai/Claude_Code.git"
echo "  git push -u origin master"
echo ""
echo "Option 2: HTTPS with GitHub CLI"
echo "  gh auth login"
echo "  git push -u origin master"
echo ""
echo "Option 3: Personal Access Token"
echo "  git push -u origin master"
echo "  (Enter your GitHub username and PAT when prompted)"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📍 Current directory: $(pwd)"
echo "🔗 Remote URL: $(git remote get-url origin)"
echo ""
