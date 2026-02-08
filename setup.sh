#!/bin/bash
# behzad-framework setup script for Linux/Mac
# Run from project root after: git submodule add https://github.com/bmottaghi/behzad-framework.git .behzad

set -e

echo ""
echo "========================================"
echo "  behzad-framework Setup"
echo "========================================"
echo ""

# Check if running from correct location
if [ ! -d ".behzad" ]; then
    echo "Error: .behzad directory not found."
    echo ""
    echo "Make sure you:"
    echo "1. Run this from your project root"
    echo "2. Have added the submodule first:"
    echo "   git submodule add https://github.com/bmottaghi/behzad-framework.git .behzad"
    echo ""
    exit 1
fi

# Step 1: Copy CLAUDE.md
echo "Step 1: Setting up CLAUDE.md..."
cp .behzad/CLAUDE.md .
echo "  ✓ Copied CLAUDE.md"

# Step 2: Create .claude/commands directory
echo "Step 2: Setting up commands..."
mkdir -p .claude/commands

# Step 3: Create symlinks for commands
for cmd in .behzad/.claude/commands/*.md; do
    if [ -f "$cmd" ]; then
        name=$(basename "$cmd")
        # Remove existing and create symlink
        rm -f ".claude/commands/$name"
        ln -s "../../.behzad/.claude/commands/$name" ".claude/commands/$name"
    fi
done

count=$(ls -1 .claude/commands/*.md 2>/dev/null | wc -l | tr -d ' ')
echo "  ✓ Setup $count commands (symlinks)"

# Step 4: Create docs structure
echo "Step 3: Setting up docs structure..."
mkdir -p docs/tech-spine docs/execution docs/learning docs/research
echo "  ✓ Docs structure ready"

# Done
echo ""
echo "========================================"
echo "  Setup Complete!"
echo "========================================"
echo ""
echo "Next steps:"
echo "1. Open this project in VSCode with Claude Code"
echo "2. Type: /init-existing"
echo ""
echo "To update the framework later:"
echo "  git submodule update --remote .behzad"
echo "  (Symlinks update automatically!)"
echo ""
