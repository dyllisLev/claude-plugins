#!/bin/bash

# MCP Server Setup Script for Claude Code
# This script configures context7 and playwright MCP servers

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

CONFIG_FILE="$HOME/Library/Application Support/Claude/claude_desktop_config.json"

echo "🔧 MCP Server Setup for Claude Code"
echo ""

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo -e "${YELLOW}Creating Claude config file...${NC}"
    mkdir -p "$(dirname "$CONFIG_FILE")"
    echo '{}' > "$CONFIG_FILE"
fi

# Read current config
CURRENT_CONFIG=$(cat "$CONFIG_FILE")

# Check if mcpServers already exists
if echo "$CURRENT_CONFIG" | grep -q "mcpServers"; then
    echo -e "${YELLOW}MCP servers already configured.${NC}"
    echo ""
    echo "Current configuration:"
    cat "$CONFIG_FILE" | grep -A 20 "mcpServers" || echo "$CURRENT_CONFIG"
    echo ""
    read -p "Do you want to overwrite? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${BLUE}Skipping MCP setup.${NC}"
        exit 0
    fi
fi

# Create new config with MCP servers
echo -e "${GREEN}Configuring MCP servers...${NC}"

cat > "$CONFIG_FILE" << 'EOF'
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upggr/context7-mcp"]
    },
    "playwright": {
      "command": "npx",
      "args": ["-y", "@executeautomation/playwright-mcp-server"]
    }
  }
}
EOF

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ MCP Servers Configured!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "📍 Configuration saved to:"
echo "   $CONFIG_FILE"
echo ""
echo "📦 Configured MCP Servers:"
echo "   • context7 - Library documentation lookup"
echo "   • playwright - Browser automation and E2E testing"
echo ""
echo "⚠️  IMPORTANT: Restart Claude app for changes to take effect!"
echo ""
echo "🔍 Verify Installation:"
echo "   1. Restart Claude app"
echo "   2. Open Claude Code: claude code"
echo "   3. Check available MCP tools:"
echo "      - mcp__context7__resolve-library-id"
echo "      - mcp__context7__query-docs"
echo "      - mcp__playwright__browser_navigate"
echo "      - mcp__playwright__browser_snapshot"
echo ""
echo "📚 MCP servers will be automatically installed on first use via npx"
echo ""

# Show current config
echo -e "${BLUE}Current Configuration:${NC}"
cat "$CONFIG_FILE"
echo ""
